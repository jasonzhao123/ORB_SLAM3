#!/usr/bin/perl 

( $root_path, $repeate, $result_file ) = @ARGV;

$argc = @ARGV;
if ( $argc < 3 ) {
    $root_path = "/tmp/orbslam/fr3_walk_xyz/fr3_walk_xyz_ate_";
    print "Root path:" . "$root_path\n";

    # Run Dataset repeately, modify if needed
    $repeate     = 3;
    $result_file = "result.txt";
}

print "Root path: $root_path\n";
print "Repeate count: $repeate\n";
print "Result path: $result_file\n";

# used to calculate average ATE RMSE vlaue
$ate_rmse   = 0;
$ate_mean   = 0;
$ate_median = 0;
$ate_std    = 0;
$ate_min    = 0;
$ate_max    = 0;

$trans_rmse   = 0;
$trans_mean   = 0;
$trans_median = 0;
$trans_std    = 0;
$trans_min    = 0;
$trans_max    = 0;

$rot_rmse   = 0;
$rot_mean   = 0;
$rot_median = 0;
$rot_std    = 0;
$rot_min    = 0;
$rot_max    = 0;

# 0: ate, 1: rpe
$is_ate_rpe = -1;

open( OUTPUT, ">$result_file" ) or die "$result_file 文件无法打开, $!";

for ( $i = 0; $i < $repeate; $i++ ) {
    $file = $root_path . "$i.txt";
    open( INPUT, "<$file" ) or die "$file 文件无法打开, $!";

    while (<INPUT>) {

        # print "$_";
        # ATE
        if ( $_ =~ /absolute_translational_error.rmse\s*([\d|.]+)/ ) {
            $ate_rmse += $1;
            $is_ate_rpe = 0;
            next;
        }
        if ( $_ =~ /absolute_translational_error.mean\s*([\d|.]+)/ ) {
            $ate_mean += $1;
            $is_ate_rpe = 0;
            next;
        }
        if ( $_ =~ /absolute_translational_error.median\s*([\d|.]+)/ ) {
            $ate_median += $1;
            $is_ate_rpe = 0;
            next;
        }
        if ( $_ =~ /absolute_translational_error.std\s*([\d|.]+)/ ) {
            $ate_std += $1;
            $is_ate_rpe = 0;
            next;
        }
        if ( $_ =~ /absolute_translational_error.min\s*([\d|.]+)/ ) {
            $ate_min += $1;
            $is_ate_rpe = 0;
            next;
        }
        if ( $_ =~ /absolute_translational_error.max\s*([\d|.]+)/ ) {
            $ate_max += $1;
            $is_ate_rpe = 0;
            next;
        }

        # Translation RPE
        if ( $_ =~ /translational_error.rmse\s*([\d|.]+)/ ) {
            $trans_rmse += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /translational_error.mean\s*([\d|.]+)/ ) {
            $trans_mean += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /translational_error.median\s*([\d|.]+)/ ) {
            $trans_median += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /translational_error.std\s*([\d|.]+)/ ) {
            $trans_std += $1;
            $is_ate_rpe = 1;
            next;
        }

        if ( $_ =~ /translational_error.min\s*([\d|.]+)/ ) {
            $trans_min += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /translational_error.max\s*([\d|.]+)/ ) {
            $trans_max += $1;
            $is_ate_rpe = 1;
            next;
        }

        # Rotation RPE
        if ( $_ =~ /rotational_error.rmse\s*([\d|.]+)/ ) {
            $rot_rmse += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /rotational_error.mean\s*([\d|.]+)/ ) {
            $rot_mean += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /rotational_error.median\s*([\d|.]+)/ ) {
            $rot_median += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /rotational_error.std\s*([\d|.]+)/ ) {
            $rot_std += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /rotational_error.min\s*([\d|.]+)/ ) {
            $rot_min += $1;
            $is_ate_rpe = 1;
            next;
        }
        if ( $_ =~ /rotational_error.max\s*([\d|.]+)/ ) {
            $rot_max += $1;
            $is_ate_rpe = 1;
            next;
        }

    }    # end while
    close(INPUT);
}    #end for

# print "RMSE: ";
# ATE
if ( $is_ate_rpe == 0 ) {
    $avg_rmse   = sprintf( "%.4f", $ate_rmse / $repeate );
    $avg_mean   = sprintf( "%.4f", $ate_mean / $repeate );
    $avg_median = sprintf( "%.4f", $ate_median / $repeate );
    $avg_std    = sprintf( "%.4f", $ate_std / $repeate );
    $avg_min    = sprintf( "%.4f", $ate_min / $repeate );
    $avg_max    = sprintf( "%.4f", $ate_max / $repeate );

    print OUTPUT "RMSE: " . "$avg_rmse\n";
    print OUTPUT "MEAN: " . "$avg_mean\n";
    print OUTPUT "MEDIAN: " . "$avg_median\n";
    print OUTPUT "STD: " . "$avg_std\n";
    print OUTPUT "MIN: " . "$avg_min\n";
    print OUTPUT "MAX: " . "$avg_max\n";
}

if ( $is_ate_rpe == 1 ) {
    # Translation RPE
    $avg_trans_rmse   = sprintf( "%.4f", $trans_rmse / $repeate );
    $avg_trans_mean   = sprintf( "%.4f", $trans_mean / $repeate );
    $avg_trans_median = sprintf( "%.4f", $trans_median / $repeate );
    $avg_trans_std    = sprintf( "%.4f", $trans_std / $repeate );
    $avg_trans_min    = sprintf( "%.4f", $trans_min / $repeate );
    $avg_trans_max    = sprintf( "%.4f", $trans_max / $repeate );

    print OUTPUT "Trans RMSE: " . "$avg_trans_rmse\n";
    print OUTPUT "Trans MEAN: " . "$avg_trans_mean\n";
    print OUTPUT "Trans MEDIAN: " . "$avg_trans_median\n";
    print OUTPUT "Trans STD: " . "$avg_trans_std\n";
    print OUTPUT "Trans MIN: " . "$avg_trans_min\n";
    print OUTPUT "Trans MAX: " . "$avg_trans_max\n";

    # Rotation RPE
    $avg_rot_rmse   = sprintf( "%.4f", $rot_rmse / $repeate );
    $avg_rot_mean   = sprintf( "%.4f", $rot_mean / $repeate );
    $avg_rot_median = sprintf( "%.4f", $rot_median / $repeate );
    $avg_rot_std    = sprintf( "%.4f", $rot_std / $repeate );
    $avg_rot_min    = sprintf( "%.4f", $rot_min / $repeate );
    $avg_rot_max    = sprintf( "%.4f", $rot_max / $repeate );

    print OUTPUT "Rotation RMSE: " . "$avg_rot_rmse\n";
    print OUTPUT "Rotation MEAN: " . "$avg_rot_mean\n";
    print OUTPUT "Rotation MEDIAN: " . "$avg_rot_median\n";
    print OUTPUT "Rotation STD: " . "$avg_rot_std\n";
    print OUTPUT "Rotation MIN: " . "$avg_rot_min\n";
    print OUTPUT "Rotation MAX: " . "$avg_rot_max\n";
}

close(OUTPUT);
