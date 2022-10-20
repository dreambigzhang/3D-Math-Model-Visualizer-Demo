// Orthogonal Projection Visualizer
import graph3;
//settings.outformat="html";
unitsize(1cm);
currentprojection=perspective(0,0,10,up=Y);
real opacity = 0.8;
pen color = green+opacity(opacity);

currentprojection=perspective(4,2,3);
// obtain the orthogonal (general) expression  of the subspace 
// using 2 orthogonal basis vectors provided
triple ortho_basis1 = gettriple("1st orthogonal basis vector: ",(1,0,1));

triple ortho_basis2 = gettriple("2nd orthogonal basis vector: ",(0,1,0));
triple coefficients = (0,0,0);

if (ortho_basis1.z==0 || ortho_basis2.z==0){
    if (ortho_basis1.z != 0) {
        coefficients = (ortho_basis1.x, ortho_basis1.y, -ortho_basis1.z);
    }
    if (ortho_basis2.z != 0) {
        coefficients = (ortho_basis2.x, ortho_basis2.y, -ortho_basis2.z);
    }
}
else {
    triple z_eliminated = ortho_basis1 - (ortho_basis1.z/ortho_basis2.z)*ortho_basis2;
    real a = z_eliminated.y;
    real b = -z_eliminated.x;
    real c = - (a*ortho_basis1.x+b*ortho_basis1.y)/ortho_basis1.z;
    coefficients = (a,b,c);
}

real f(pair z) {
    return (coefficients.x*z.x + coefficients.y*z.y)/(-coefficients.z);
    }

triple original = gettriple("Vector to project ",(-2,2,3));

path3 p3 = ((0,0,0)--original);
draw(p3, red, Arrow3);

// Gram-Schmidt Process: u1, u2 (ortho_basis1 and ortho_basis2) MUST BE ORTHOGONAL BASIS
triple ortho_proj(triple v, triple u1, triple u2){
    triple part1 = dot(v, u1)/dot(u1,u1)*u1;
    triple part2 = dot(v, u2)/dot(u2,u2)*u2;
    triple proj = part1+part2;
    return proj;
}

triple proj = ortho_proj(original,ortho_basis1, ortho_basis2);
write("Projection: ", proj);
path3 p_proj = ((0,0,0)--proj);
draw(p_proj, red+dashed, Arrow3);
path3 p4 = (original--proj);
draw(p4, red+dashed);

draw(surface(f,(-4,-4),(4,4),nx=10,Spline),color,render(merge=true));

draw(Label("$y$",1),(0,0,0)--(0,2,0),Arrow3);
draw(Label("$x$",1),(0,0,0)--(2,0,0),Arrow3);
draw(Label("$z$",1),(0,0,0)--(0,0,2.5),Arrow3);