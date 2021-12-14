<?php

function create_matrix($x, $y) {
    for($i = 0; $i <= $x; $i++) {
        $row = array();

        for($j = 0; $j <= $y; $j++) {
            $row[] = 0;
        }

        $matrix[]  = $row;

    }
    return $matrix;
}

function display_matrix($matrix) {
    foreach($matrix as $row) {
        foreach($row as $cell) {
            if ($cell == 1) {
                print("#");
            } else {
                print(".");
            }
        }
        print("\n");
    }
}

$file_content = file_get_contents("input2.txt");

$lines = explode("\n", $file_content);

$max_x = 0;
$max_y = 0;


$coordinates = array();

foreach($lines as $line) {
    if ($line == "") continue;
    $l = explode(",", $line);
    $x = $l[1];
    $y = $l[0];

    if ( $x > $max_x ) {
        $max_x = $x;
    }

    if ( $y > $max_y ) {
        $max_y = $y;
    }

    $coordinates[] = array(intval($x), intval($y));
}

$matrix = create_matrix($max_x, $max_y);

foreach($coordinates as $coordinate) {
    $x = $coordinate[0];
    $y = $coordinate[1];
    $matrix[$x][$y] = 1;
}

$folds = array(
    array("x",655),
    array("y",447),
    array("x",327),
    array("y",223),
    array("x",163),
    array("y",111),
    array("x",81),
    array("y",55),
    array("x",40),
    array("y",27),
    array("y",13),
    array("y",6)
);

$current_matrix = $matrix;
$new_coordinates = $coordinates;

foreach($folds as $fold) {

    if ($fold[0] == "x") {
        list($current_matrix, $new_coordinates) = fold($current_matrix, $fold[1], 0, $new_coordinates);

    } else {

        list($current_matrix, $new_coordinates) = fold($current_matrix, 0, $fold[1], $new_coordinates);
    }

    display_matrix($current_matrix);
}


function fold($matrix, $fold_x, $fold_y, $coordinates) {
    
    // If we fold on the y axis, we have to divide the matrix by x / fold_x
    if ($fold_x) {
        $divide = count($matrix[0]) / $fold_x;
        $fold_matrix = create_matrix(count($matrix) - 1, count($matrix[0]) / $divide - 1);
    } else {
        $divide = count($matrix) / $fold_y;
        $fold_matrix = create_matrix(count($matrix) / $divide - 1, count($matrix[0]) - 1);
    }

    if ($fold_x) {
        foreach($coordinates as $coordinate) {
            $x = $coordinate[0];
            $y = $coordinate[1];
            
            if ($y > $fold_x) {

                // Probably an easier way...
                $dist_middle = $y - ( $fold_x + 1 );
                $dist_target = ( $fold_x + 1 ) - $dist_middle;
                $new_y = $dist_target - 1 - 1;
                $fold_matrix[$x][$new_y] = 1;
            } else {
                $fold_matrix[$x][$y] = 1;
            }
        }
    } else {
        foreach($coordinates as $coordinate) {
            $x = $coordinate[0];
            $y = $coordinate[1];
            
            if ($x > $fold_y) {

                // Probably an easier way...
                $dist_middle = $x - ( $fold_y + 1 );
                $dist_target = ( $fold_y + 1 ) - $dist_middle;
                $new_x = $dist_target - 1 - 1;
                var_dump($new_x);
                var_dump($y);
                $fold_matrix[$new_x][$y] = 1;
            } else {

                $fold_matrix[$x][$y] = 1;
            }
        }
    }
    
    $new_coordinates = array();
    for($i = 0; $i < count($fold_matrix); $i++) {
        $row = array();
        
        for($j = 0; $j < count($fold_matrix[0]); $j++) {

            if($fold_matrix[$i][$j] == 1) {
                $new_coordinates[] = array($i, $j);
            }
        }
    }

    return array($fold_matrix, $new_coordinates);
}
