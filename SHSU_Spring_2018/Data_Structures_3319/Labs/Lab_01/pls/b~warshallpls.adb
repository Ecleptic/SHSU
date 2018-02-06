pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~warshallpls.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~warshallpls.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E076 : Short_Integer; pragma Import (Ada, E076, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exception_table_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "ada__containers_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__io_exceptions_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__tags_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "ada__streams_E");
   E074 : Short_Integer; pragma Import (Ada, E074, "interfaces__c_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exceptions_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "system__file_control_block_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__streams__stream_io_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "system__file_io_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "system__finalization_root_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "ada__finalization_E");
   E097 : Short_Integer; pragma Import (Ada, E097, "system__storage_pools_E");
   E091 : Short_Integer; pragma Import (Ada, E091, "system__finalization_masters_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "system__storage_pools__subpools_E");
   E009 : Short_Integer; pragma Import (Ada, E009, "system__secondary_stack_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "system__strings__stream_ops_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "ada__text_io_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E067 := E067 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__text_io__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__file_io__finalize_body");
      begin
         E072 := E072 - 1;
         F2;
      end;
      E091 := E091 - 1;
      E099 := E099 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__storage_pools__subpools__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__finalization_masters__finalize_spec");
      begin
         F4;
      end;
      E107 := E107 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__streams__stream_io__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E019 := E019 + 1;
      Ada.Containers'Elab_Spec;
      E044 := E044 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E050 := E050 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E049 := E049 + 1;
      Interfaces.C'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E021 := E021 + 1;
      System.File_Control_Block'Elab_Spec;
      E079 := E079 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E107 := E107 + 1;
      System.Finalization_Root'Elab_Spec;
      E065 := E065 + 1;
      Ada.Finalization'Elab_Spec;
      E047 := E047 + 1;
      System.Storage_Pools'Elab_Spec;
      E097 := E097 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      E099 := E099 + 1;
      System.Finalization_Masters'Elab_Body;
      E091 := E091 + 1;
      System.File_Io'Elab_Body;
      E072 := E072 + 1;
      E074 := E074 + 1;
      Ada.Tags'Elab_Body;
      E052 := E052 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Os_Lib'Elab_Body;
      E076 := E076 + 1;
      System.Secondary_Stack'Elab_Body;
      E009 := E009 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E105 := E105 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E067 := E067 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_brewer");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   ./warshallpls.o
   --   -L./
   --   -L/Users/cgreen/Documents/SHSU 👾 /SHSU_Spring_2018/Data_Structures_3319/Labs/Lab_01/pls/
   --   -L/usr/local/gnat/lib/gcc/x86_64-apple-darwin13.4.0/4.9.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
