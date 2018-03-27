with Ada.Containers.Hashed_Maps;  use Ada.Containers;

package Regional is

   type Language_ID is (DE, EL, EN, ES, FR, NL);
   --  a selection from the two-letter codes for human languages

   type Hello_Text is access constant Wide_String;
   --  objects will contain a «hello»-string in some language


   function ID_Hashed (id: Language_ID) return Hash_Type;
   --  you need to provide this to every hashed container

   package Phrases is new Ada.Containers.Hashed_Maps
     (Key_Type => Language_ID,
      Element_Type => Hello_Text,
      Hash => ID_Hashed,
      Equivalent_Keys => "=");

end Regional;