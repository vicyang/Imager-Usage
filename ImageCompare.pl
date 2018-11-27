use strict;
use Imager;
use Encode;
use List::Util qw/sum/;
STDOUT->autoflush(1);

our $SIZE = 24;
our $font = Imager::Font->new(file  => encode('gbk', 'C:/windows/fonts/simsun.ttc'), #STXINGKA.TTF
                          size  => $SIZE, type => 'ft2' );
our $bbox = $font->bounding_box(string=>"_");

my $img1 = get_text("0");
my $img2 = get_text("O");

my $diff = $img1->difference(other=>$img2);
my ($w, $h) = ($diff->getwidth, $diff->getheight);

my @colors;
for my $y ( 0 .. $h - 1 )
{
    @colors = $diff->getscanline( y => $y );
    grep { printf "%s", sum($_->rgba) > 500 ? ".":" " } @colors;
    printf "\n";
}

sub get_text
{
    our ($font, $SIZE);
    my ( $char ) = @_;

    my $bbox = $font->bounding_box( string => $char );
    my $img = Imager->new(xsize=>$bbox->advance_width,
                          ysize=>$bbox->font_height, channels=>4);

    my $h = $img->getheight();
    my $w = $img->getwidth();

    # 填充画布背景色
    $img->box(xmin => 0, ymin => 0, xmax => $w, ymax => $h,
            filled => 1, color => 'white');

    $img->align_string(
               font  => $font,
               text  => $char,
               x     => $w/2.0,
               y     => $h + $bbox->global_descent,
               size  => $SIZE,
               color => 'black',
               aa    => 1,     # anti-alias
               halign => 'center',
            );

    #$img->filter(type=>"hardinvert");

    return $img;
}

