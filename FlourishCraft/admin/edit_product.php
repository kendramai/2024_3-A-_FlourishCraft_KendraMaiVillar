<?php
include_once "../db.php";

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$set_id = isset($_GET['set_id']) ? $_GET['set_id'] : 0;

$sql_set = "SELECT s.Set_Name, s.Description, s.Variation, s.Cost, s.Set_Img, p.Price 
            FROM `set` s 
            JOIN price p ON s.Price_ID = p.Price_ID 
            WHERE s.Set_ID = ?";
$stmt_set = $conn->prepare($sql_set);
$stmt_set->bind_param("i", $set_id);
$stmt_set->execute();
$result_set = $stmt_set->get_result();

if ($result_set->num_rows == 0) {
    die("Product not found.");
}

$set = $result_set->fetch_assoc();

$sql_raw_materials = "SELECT cost_raw_materials_ID, raw_materials_name, cost FROM cost_raw_materials";
$result_raw_materials = $conn->query($sql_raw_materials);

$sql_selected_materials = "SELECT cost_raw_materials_ID, Qty 
                           FROM sets_raw_materials 
                           WHERE Set_ID = ?";
$stmt_selected_materials = $conn->prepare($sql_selected_materials);
$stmt_selected_materials->bind_param("i", $set_id);
$stmt_selected_materials->execute();
$result_selected_materials = $stmt_selected_materials->get_result();

$selected_materials = [];
while ($row = $result_selected_materials->fetch_assoc()) {
    $selected_materials[$row['cost_raw_materials_ID']] = $row['Qty'];
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["edit_product"])) {
    $set_name = $_POST["set_name"];
    $description = $_POST["description"];
    $variation = $_POST["variation"];
    $price = $_POST["price"];
    $selected_raw_materials = $_POST["raw_materials"] ?? [];
    $quantities = $_POST["quantities"] ?? [];

    $total_cost = 0;
    foreach ($selected_raw_materials as $material_id) {
        $quantity = isset($quantities[$material_id]) ? $quantities[$material_id] : 1;
        $sql_cost = "SELECT cost FROM cost_raw_materials WHERE cost_raw_materials_ID = ?";
        $stmt_cost = $conn->prepare($sql_cost);
        $stmt_cost->bind_param("i", $material_id);
        $stmt_cost->execute();
        $result_cost = $stmt_cost->get_result();

        if ($result_cost->num_rows > 0) {
            $row = $result_cost->fetch_assoc();
            $total_cost += $row["cost"] * $quantity;
        }
        $stmt_cost->close();
    }

    $cost = $total_cost;

    $check_price_sql = "SELECT Price_ID FROM price WHERE Price = ?";
    $check_price_stmt = $conn->prepare($check_price_sql);
    $check_price_stmt->bind_param("d", $price);
    $check_price_stmt->execute();
    $check_price_stmt->store_result();

    if ($check_price_stmt->num_rows == 0) {

        $insert_price_sql = "INSERT INTO price (Price) VALUES (?)";
        $insert_price_stmt = $conn->prepare($insert_price_sql);
        $insert_price_stmt->bind_param("d", $price);
        if ($insert_price_stmt->execute()) {
            $price_id = $insert_price_stmt->insert_id;
        } else {
            echo "<div class='alert alert-danger'>Error inserting price: " . $insert_price_stmt->error . "</div>";
            exit;
        }
        $insert_price_stmt->close();
    } else {
        $check_price_stmt->bind_result($price_id);
        $check_price_stmt->fetch();
    }
    $check_price_stmt->close();

    $image_name = $set['Set_Img'];
    if (!empty($_FILES["set_img"]["name"])) {
        $target_dir = $_SERVER['DOCUMENT_ROOT'] . "/FlourishCraft/images/";
        $image_name = basename($_FILES["set_img"]["name"]);
        $target_file = $target_dir . $image_name;
        $uploadOk = 1;
        $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

        $check = getimagesize($_FILES["set_img"]["tmp_name"]);
        if ($check !== false) {
            $uploadOk = 1;
        } else {
            echo "<div class='alert alert-danger'>File is not an image.</div>";
            $uploadOk = 0;
        }

        if (file_exists($target_file)) {
            $image_name = pathinfo($image_name, PATHINFO_FILENAME) . '_' . time() . '.' . $imageFileType;
            $target_file = $target_dir . $image_name;
        }

        if ($_FILES["set_img"]["size"] > 500000) {
            echo "<div class='alert alert-danger'>Sorry, your file is too large.</div>";
            $uploadOk = 0;
        }

        if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
            echo "<div class='alert alert-danger'>Sorry, only JPG, JPEG, PNG & GIF files are allowed.</div>";
            $uploadOk = 0;
        }

        if ($uploadOk == 0) {
            echo "<div class='alert alert-danger'>Sorry, your file was not uploaded.</div>";
        } else {
            if (move_uploaded_file($_FILES["set_img"]["tmp_name"], $target_file)) {
                echo "<div class='alert alert-success'>The file " . htmlspecialchars($image_name) . " has been uploaded.</div>";
            } else {
                echo "<div class='alert alert-danger'>Sorry, there was an error uploading your file.</div>";
            }
        }
    }

    $sql_update_set = "UPDATE `set` 
                       SET Set_Name = ?, Description = ?, Variation = ?, Cost = ?, Set_Img = ?, Price_ID = ? 
                       WHERE Set_ID = ?";
    $stmt_update_set = $conn->prepare($sql_update_set);
    if ($stmt_update_set) {
        $stmt_update_set->bind_param("sssssii", $set_name, $description, $variation, $cost, $image_name, $price_id, $set_id);
        if ($stmt_update_set->execute()) {

            $sql_delete_materials = "DELETE FROM sets_raw_materials WHERE Set_ID = ?";
            $stmt_delete_materials = $conn->prepare($sql_delete_materials);
            $stmt_delete_materials->bind_param("i", $set_id);
            $stmt_delete_materials->execute();
            $stmt_delete_materials->close();

            foreach ($selected_raw_materials as $material_id) {
                $sql_insert_material = "INSERT INTO sets_raw_materials (cost_raw_materials_ID, Set_ID, Qty) VALUES (?, ?, ?)";
                $stmt_insert_material = $conn->prepare($sql_insert_material);
                $qty = isset($quantities[$material_id]) ? $quantities[$material_id] : 1;
                $stmt_insert_material->bind_param("iii", $material_id, $set_id, $qty);
                $stmt_insert_material->execute();
                $stmt_insert_material->close();
            }

            header("Location: admin_index.php?message=Product updated successfully.");
            exit;
        } else {
            echo "<div class='alert alert-danger'>Error updating product: " . $stmt_update_set->error . "</div>";
        }
        $stmt_update_set->close();
    } else {
        echo "<div class='alert alert-danger'>Error preparing set update statement: " . $conn->error . "</div>";
    }
}

$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../styles/edit_product.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Edit Product</h2>
        <form action="" method="POST" class="mb-4" enctype="multipart/form-data">
            <input type="hidden" name="edit_product" value="1">

            <div class="form-group">
                <label for="set_name">Set Name:</label>
                <input type="text" id="set_name" name="set_name" class="form-control" value="<?php echo htmlspecialchars($set['Set_Name']); ?>">
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control"><?php echo htmlspecialchars($set['Description']); ?></textarea>
            </div>

            <div class="form-group">
                <label for="variation">Variation:</label>
                <input type="text" id="variation" name="variation" class="form-control" value="<?php echo htmlspecialchars($set['Variation']); ?>">
            </div>

            <div class="form-group">
                <label for="raw_materials">Select Raw Materials:</label>
                <div id="raw_materials">
                    <?php
                    if ($result_raw_materials->num_rows > 0) {
                        while($row = $result_raw_materials->fetch_assoc()) {
                            $checked = isset($selected_materials[$row['cost_raw_materials_ID']]) ? "checked" : "";
                            $quantity = isset($selected_materials[$row['cost_raw_materials_ID']]) ? $selected_materials[$row['cost_raw_materials_ID']] : 1;
                            echo "<div class='form-check'>";
                            echo "<input class='form-check-input' type='checkbox' name='raw_materials[]' value='" . $row['cost_raw_materials_ID'] . "' id='material_" . $row['cost_raw_materials_ID'] . "' $checked>";
                            echo "<label class='form-check-label' for='material_" . $row['cost_raw_materials_ID'] . "'>" . $row['raw_materials_name'] . " (₱" . $row['cost'] . ")</label>";
                            echo "<input type='number' name='quantities[" . $row['cost_raw_materials_ID'] . "]' value='" . $quantity . "' min='1' class='form-control quantity-input' data-material-id='" . $row['cost_raw_materials_ID'] . "' style='width: 100px; display: inline-block; margin-left: 10px;'>";
                            echo "</div>";
                        }
                    } else {
                        echo "<p>No raw materials found</p>";
                    }
                    ?>
                </div>
            </div>

            <div class="form-group">
                <label for="selected-materials">Selected Raw Materials:</label>
                <div id="selected-materials"></div>
            </div>

            <div class="form-group">
                <label for="cost">Total Cost:</label>
                <input type="number" step="0.01" id="cost" name="cost" class="form-control" value="<?php echo htmlspecialchars($set['Cost']); ?>" readonly>
            </div>

            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" class="form-control" value="<?php echo htmlspecialchars($set['Price']); ?>">
            </div>

            <div class="form-group">
                <label for="set_img">Set Image:</label>
                <input type="file" id="set_img" name="set_img" class="form-control">
                <img src="/FlourishCraft/images/<?php echo htmlspecialchars($set['Set_Img']); ?>" alt="Current Image" style="width: 150px; height: auto; margin-top: 10px;">
            </div>

            <div class="form-group text-center"> 
    <button type="submit" class="btn btn-primary">Update Product</button>
</div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
    function updateTotalCost() {
        var totalCost = 0;
        var selectedList = '';

        $('input[name="raw_materials[]"]:checked').each(function() {
            var materialId = $(this).val();
            var quantity = $('input[name="quantities[' + materialId + ']"]').val();
            var materialName = $('label[for="material_' + materialId + '"]').text().split(' ($')[0];
            var materialCost = parseFloat($('label[for="material_' + materialId + '"]').text().match(/\$(\d+(\.\d+)?)/)[1]);

            totalCost += materialCost * quantity;
            selectedList += '<li>' + materialName.trim() + ' - Quantity: ' + quantity + '</li>';
        });

        $('#cost').val(totalCost.toFixed(2));

        $('#selected-materials').html('<ul>' + selectedList + '</ul>');
    }

    $('input[name="raw_materials[]"], .quantity-input').change(updateTotalCost);

    updateTotalCost();
    </script>
</body>
</html>