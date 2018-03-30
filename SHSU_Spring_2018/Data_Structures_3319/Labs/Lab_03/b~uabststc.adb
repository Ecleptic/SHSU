pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~uabststc.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~uabststc.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E090 : Short_Integer; pragma Import (Ada, E090, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__io_exceptions_E");
   E007 : Short_Integer; pragma Import (Ada, E007, "ada__tags_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__streams_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "interfaces__c_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E093 : Short_Integer; pragma Import (Ada, E093, "system__file_control_block_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__file_io_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__finalization_root_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "ada__finalization_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "system__storage_pools_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "system__finalization_masters_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "system__storage_pools__subpools_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__pool_global_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "ada__text_io_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "abststck_E");
   E095 : Short_Integer; pragma Import (Ada, E095, "makecar_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "makeplane_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E117 := E117 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "makeplane__finalize_spec");
      begin
         F1;
      end;
      E095 := E095 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "makecar__finalize_spec");
      begin
         F2;
      end;
      E005 := E005 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "abststck__finalize_spec");
      begin
         F3;
      end;
      E082 := E082 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__text_io__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__file_io__finalize_body");
      begin
         E086 := E086 - 1;
         F5;
      end;
      E061 := E061 - 1;
      E119 := E119 - 1;
      E075 := E075 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__pool_global__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__storage_pools__subpools__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__finalization_masters__finalize_spec");
      begin
         F8;
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
      E025 := E025 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E059 := E059 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.File_Control_Block'Elab_Spec;
      E093 := E093 + 1;
      System.Finalization_Root'Elab_Spec;
      E071 := E071 + 1;
      Ada.Finalization'Elab_Spec;
      E069 := E069 + 1;
      System.Storage_Pools'Elab_Spec;
      E073 := E073 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Pool_Global'Elab_Spec;
      E075 := E075 + 1;
      E119 := E119 + 1;
      System.Finalization_Masters'Elab_Body;
      E061 := E061 + 1;
      System.File_Io'Elab_Body;
      E086 := E086 + 1;
      E088 := E088 + 1;
      Ada.Tags'Elab_Body;
      E007 := E007 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Os_Lib'Elab_Body;
      E090 := E090 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E082 := E082 + 1;
      Abststck'Elab_Spec;
      E005 := E005 + 1;
      Makecar'Elab_Spec;
      Makecar'Elab_Body;
      E095 := E095 + 1;
      Makeplane'Elab_Spec;
      Makeplane'Elab_Body;
      E117 := E117 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_uabststc");

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
   --   ./abststck.o
   --   ./makecar.o
   --   ./makeplane.o
   --   ./uabststc.o
   --   -L./
   --   -L/Users/cgreen/Documents/SHSU_👾./SHSU_Spring_2018/Data_Structures_3319/Labs/Lab_03/
   --   -L/usr/local/gnat/lib/gcc/x86_64-apple-darwin13.4.0/4.9.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
