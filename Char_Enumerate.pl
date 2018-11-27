use strict;
use Imager;
use Encode;
use List::Util qw/sum/;
STDOUT->autoflush(1);

our $SIZE = 12;
our $font = Imager::Font->new(file  => encode('gbk', 'C:/windows/fonts/arial.ttf'), #STXINGKA.TTF
                          size  => $SIZE, type => 'ft2' );
my $img = Imager->new(xsize=>$SIZE,
                      ysize=>$SIZE, channels=>4);


for my $code ( 0 .. 60000 )
{
    my $res = $font->has_chars( string=>chr($code) );
    # Not all fonts support this method (use $font->can("has_chars") to check.)
    # 实测返回 <0x01> 或者 <0x00> (字符形式)
    if ( ord($res) == 1 ) { printf "%d %s\n", $code, encode('gbk', chr($code)) }
}


