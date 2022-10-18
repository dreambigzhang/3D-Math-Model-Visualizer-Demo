// Perform orthogonal projection and calculate the distance between a point and a plane

import graph3;
settings.outformat="html";
unitsize(1cm);
currentprojection=perspective(0,0,10,up=Y);
real opacity = 0.8;
pen color = purple+opacity(opacity);

currentprojection=perspective(4,2,3);

real a, b, c = 0;
write("Input a, b, c, d to express the plane in the form ax+by+cz = d");

bool allZero = true;
while (allZero) {
    write("At least one of a, b, c needs to be none-zero");
    a = getreal("a",2);
    b = getreal("b",3);
    c = getreal("c",-1);
    if (!(a==0&&b==0&&c==0)){
        allZero = false;
    }
}

real d = getreal("d",5);

triple f (pair t) {
    real x = (d-b*t.x-c*t.y)/a;
    return (x,t.x,t.y);
}

triple pointOnPlane = (0,0,0);
if (c!=0) {
    pointOnPlane = (1,1,(d-a-b)/c);
}
else if (a!=0) {
    pointOnPlane = ((d-b-c)/a,1,1);
}
else {
    pointOnPlane = (1,(d-a-c)/b,1);
}

triple normalVector = (a,b,c);
//draw(normal);
triple point = gettriple("Point",(5,2,3));
string s = (string)point;
dot(Label(s),point);

draw(surface(f,(-4,-4),(4,4),Spline),color,render(merge=true));

triple vectorU = point - pointOnPlane;
triple vectorV = normalVector;//+ pointOnPlane;
triple projToNormal = project(vectorU, vectorV);
triple projToPlane = vectorU - projToNormal;

real distance = length(projToNormal);

path3 pointToPoint = (pointOnPlane--point);
path3 distancePath = ((projToPlane+pointOnPlane)--point);
path3 projPath = (pointOnPlane--(projToPlane+pointOnPlane));

draw(pointToPoint,red, Arrow3);
draw(projPath,red, Arrow3);
draw(Label(erase(string(distance),5,-1), MidPoint), distancePath, red, Arrow3);
write("Distance between the point and the plane:");
write(distance);

xaxis3(Label("$x$"),Arrow3);
yaxis3(Label("$y$"),Arrow3);
zaxis3(Label("$z$"),Arrow3);