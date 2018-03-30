-- in file MakeCar.ads
with AbstStck;

package MakeCar is

    type String4 is new String(1..4);
    type Car is new AbstStck.AbstractStackElement with record
        NumDoors: integer;
        Manufacturer: String4 := "GMC "; -- Sample default value.
    end record;

    procedure AssignNumDoors(aCar: in out Car; N: in integer);
    procedure AssignManufacturer(aCar: in out Car; Manu: in String4);
    procedure PrintNumDoors(aCar: in Car);
    procedure PrintManufacturer(aCar: in Car);
    procedure IdentifyVehicle(aCar: in Car);

end MakeCar;