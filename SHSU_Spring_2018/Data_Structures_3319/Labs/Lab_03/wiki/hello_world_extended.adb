with Regional; use Regional;
with Ada.Wide_Text_IO; use Ada;

procedure Hello_World_Extended is

   --  print greetings in different spoken languages

   greetings: Phrases.Map;
   --  the dictionary of greetings

begin -- Hello_World_Extended

   Phrases.Insert(greetings,
                  Key => EN,
                  New_Item => new Wide_String'("Hello, World!"));

   --  or, shorter,
   greetings.Insert(DE, new Wide_String'("Hallo, Welt!"));
   greetings.Insert(NL, new Wide_String'("Hallo, Wereld!"));
   greetings.Insert(ES, new Wide_String'("¡Hola mundo!"));
   greetings.Insert(FR, new Wide_String'("Bonjour, Monde!"));
   greetings.Insert(EL, new Wide_String'("Γεια σου κόσμε"));

   declare
      use Phrases;

      speaker: Cursor := First(greetings);
   begin
      while Has_Element(speaker) loop
         Wide_Text_IO.Put_Line( Element(speaker).all );
         Next(speaker);
      end loop;
   end;

end Hello_World_Extended;