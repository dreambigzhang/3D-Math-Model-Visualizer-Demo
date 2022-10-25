// Visualizer for linear transformation of 2 dimentional matrices
import graph3;
import solids;
import three;
settings.outformat="html";
size3(10cm,keepAspect = true);
//currentprojection=perspective(0,0,10,up=Y);
real opacity = 1;
pen color = purple+opacity(opacity);

currentprojection=orthographic(4,2,3);
triple basis1 = gettriple("1st basis vector: ",(1,0,1));
triple basis2 = gettriple("2nd basis vector: ",(0,1,0));
triple normal = cross(basis1,basis2);

path3 p1 = ((0,0,0)--basis1);
path3 p2 = ((0,0,0)--basis2);
path3 p3 = ((0,0,0)--normal);

triple a, b, c= (0,0,0);
write("Input the rows of 3x3 matrix in tuples: e.g. (2,3,4)");

bool allZero = true;
while (allZero) {
    write("At least one of a, b, c needs to be none-zero");
    a = gettriple("a",(1,2,-3));
    b = gettriple("b",(2,3,4));
    c = gettriple("c",(-4,2,1));
    if (!(a==(0,0,0)&&b==(0,0,0)&&c==(0,0,0))){
        allZero = false;
    }
}
write("Before transformation - Purple");
write("After transformation - Green");
draw(transform3(basis1,basis2)*unitplane,color);
draw(p1, blue,Arrow3);
draw(p2, blue,Arrow3);

basis1 = (basis1.x*a.x+basis1.y*a.y+basis1.z*a.z, basis1.x*b.x+basis1.y*b.y+basis1.z*b.z, basis1.x*c.x+basis1.y*c.y+basis1.z*c.z);
basis2 = (basis2.x*a.x+basis2.y*a.y+basis2.z*a.z, basis2.x*b.x+basis2.y*b.y+basis2.z*b.z, basis2.x*c.x+basis2.y*c.y+basis2.z*c.z);

p1 = ((0,0,0)--basis1);
p2 = ((0,0,0)--basis2);

draw(transform3(basis1,basis2)*unitplane, green+opacity(opacity));
draw(p1, red,Arrow3);
draw(p2, red,Arrow3);

xaxis3(Label("$x$"),Arrow3);
yaxis3(Label("$y$"),Arrow3);
zaxis3(Label("$z$"),Arrow3);