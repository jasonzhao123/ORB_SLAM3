#!/usr/bin/perl 

( $root_path, $repeate, $result_file ) = @ARGV;

$argc = @ARGV;
if ( $argc < 3 ) {
    $root_path = "/tmp/orbslam/fr3_walk_xyz/fr3_walk_xyz_ate_";
    print "Root path:" . "$root_path\n";

    # Run Dataset repeately, modify if needed
    $repeate = 3;
    $result_file="result.txt";
}
 
print "Root path: $root_path\n";
print "Repeate count: $repeate\n";
print "Result path: $result_file\n";

# used to calculate average ATE RMSE vlaue
$rmse   = 0;
$mean   = 0;
$median = 0;
$std    = 0;
$min    = 0;
$max    = 0;

open( OUTPUT, ">$result_file" ) or die "$result_file 文件无法打开, $!";

for ( $i = 0; $i < $repeate; $i++ ) {
    $file = $root_path . "$i.txt";
    open( INPUT, "<$file" ) or die "$file 文件无法打开, $!";

    while (<INPUT>) {

        # print "$_";
        if ( $_ =~ /rmse\s*([\d|.]+)/ ) {
            $rmse += $1;
        }
        if ( $_ =~ /mean\s*([\d|.]+)/ ) {
            $mean += $1;
        }
        if ( $_ =~ /median\s*([\d|.]+)/ ) {
            $median += $1;
        }
        if ( $_ =~ /std\s*([\d|.]+)/ ) {
            $std += $1;
        }
        if ( $_ =~ /min\s*([\d|.]+)/ ) {
            $min += $1;
        }
        if ( $_ =~ /max\s*([\d|.]+)/ ) {
            $max += $1;
        }
    }    # end while
    close(INPUT);
}    #end for

# print "RMSE: ";
$avg_rmse   = $rmse / $repeate;
$avg_mean   = $mean / $repeate;
$avg_median = $median / $repeate;
$avg_std    = $std / $repeate;
$avg_min    = $min / $repeate;
$avg_max    = $max / $repeate;

print OUTPUT "RMSE: " . "$avg_rmse\n";
print OUTPUT "MEAN: " . "$avg_mean\n";
print OUTPUT "MEDIAN: " . "$avg_median\n";
print OUTPUT "STD: " . "$avg_std\n";
print OUTPUT "MIN: " . "$avg_min\n";
print OUTPUT "MAX: " . "$avg_max\n";

close(OUTPUT);
