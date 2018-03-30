-- Creation of a “cube” type from a “rectangle” type using inheritance.
--in file taged1.adb
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure taged1 is
    type Rectangle is tagged -- tagged allows inheritance
    record
        length: Integer;
        width: Integer;
    end record;

    function Size(r: in Rectangle) return Integer is -- “intrinsic” method
    begin
        return r.length * r.width;
    end Size;

    -- create a cube by inheriting from Rectangle.

    type Cube is new Rectangle with -- create cube using inheritance
    record
        height: Integer;
    end record;

    -- Cube inherits fields length, width, and function Size.
    -- This size may be redefined as:

    function Size(c: Cube) return Integer is -- intrinsic function begin
    return
        Size( Rectangle( C ) ) * C.height; -- cast “Cube” as a rectangle.
    end Size;

    -- Note the type conversion "Rectangle(c)" so that the inherited
    -- function Size for Rectangle (overload) can be used.

    rect1: Rectangle := (6,10);
    cube1: Cube := (length => 6, width => 10, height => 20);

    begin
        put( Size( rect1 ) ); put( Size( cube1 ) );
        rect1 := Rectangle( cube1 ); cube1 := ( rect1 with 20 );
    end taged1;
    -- User-written subprograms are classified as primitive operations
    -- if they are declared in the same package specification as the
    -- type and have the type as a parameter or result. Derived types
    -- inherit all primitive operations that belong to the parent type.