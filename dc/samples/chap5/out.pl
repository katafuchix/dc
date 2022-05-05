#!/usr/bin/perl 
#print "Content-type: image/jpeg\n\n";

use strict;
use Image::Magick;

eval{
my $file = "gd_sample.PNG";

my $image = Image::Magick->new;

$image->Read($file);

print '1';

#$image->Emboss(radius=>2, sigma=>1);

print '2';

$image->Write("output.png");

binmode STDOUT;
#$image->Write("jpeg:-"); 
undef $image;

print '2';
};

			if($@){
				print $@;
			}
exit;
