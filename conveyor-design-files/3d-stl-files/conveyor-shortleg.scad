echo(version=version());


module chamfer(len,r,rs=4)
{
	p=r+0.1;
	linear_extrude(height=len) difference()
	{
		square([p,p]);
		circle(r,$fn=(rs+1)*4);
	}
}

//chamfer(10,14,20);

x =   0;
y =   0;
h =  20;
w = 230;

difference()
{
  union()
  {
    color("red" ) 
    {
      translate([x         ,y         , 0]) cylinder(r=10,h=10,center=true,$fn = 200);
      translate([x + w     ,y         , 0]) cylinder(r=10,h=10,center=true,$fn = 200);
      translate([x         ,y + h     , 0]) cylinder(r=10,h=10,center=true,$fn = 200);
      translate([x + w     ,y + h     , 0]) cylinder(r=10,h=10,center=true,$fn = 200);
    }
    color("blue" )
    {
      translate([x         ,y + h - 10,-5]) cube([  w,20,10]);
      translate([x -     10,y         ,-5]) cube([ 20, h,10]);
      translate([x + w - 10,y         ,-5]) cube([ 20, h,10]);
    }
  }
  union()
  {
    color("green"){ 
    translate([  0    ,  0,-0.1]) cylinder(r=1.5, h=10, center=true,$fn = 200);
    translate([  0    ,  0,   5]) cylinder(r=  3, h=10, center=true,$fn = 200);

    translate([  x + w,  0,-0.1]) cylinder(r=1.5, h=10, center=true,$fn = 200);
    translate([  x + w,  0,   5]) cylinder(r=  3, h=10, center=true,$fn = 200);
  }
  }
}
