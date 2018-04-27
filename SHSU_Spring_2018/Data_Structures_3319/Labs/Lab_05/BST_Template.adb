with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


package body BST_Template is


	Root: BinarySearchTreePoint := new Node;
	Stack: array(1..20) of BinarySearchTreePoint;
	count: integer := 1;


	procedure createRoot is
		newRecord: Customer;
	begin
		put_line("Creating root");
		Root.Info := newRecord;
		Root.RTag := true;
		Root.LTag := false;
		Root.Rlink := Root;
		Root.Llink := Root;
	end createRoot;

	procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint; custName: in string10; custPhone: string10) is
		P: BinarySearchTreePoint;
		T: BinarySearchTreePoint;
		-- newRecord: Customer;
	begin
		-- put_line("InsertBinarySearchTree");
      if Root = null then
			-- createRoot;
			put_line("no root");
			allocateNode(root,custName, custphone);
         T := Root;
      else
			-- put("not null");
			p := Root;
			loop
				if custname < P.Info.Name then
					-- put("custname < pname");
					if P.LTag then
						-- put("ltag");
						p := p.Llink;
					else
						-- put("ltag else");
						allocateNode(T,custname,custphone);
						insertNode(p,t,custName,custphone);
						--InsertBinarySearchTree(T.LLink, custname,custphone);
						exit;
					end if;
				elsif custname > p.info.name then
					-- put("custname > pname");
					if p.RTag then
						-- put("rtag");
						p := p.Rlink;
					else
						-- put("rtag else");
						allocateNode(T,custname,custphone);
						insertNode(p,t,custName,custphone);
						exit;
					end if;
				else
					-- put("custname < pname else ");
					allocateNode(T,custname,custphone);
					insertNode(P,T,custName,custphone);
					-- InsertBinarySearchTree(T.RLink, custname,custphone);
					exit;
				end if;
			end loop;
		end if;
	end InsertBinarySearchTree;

	--procedure FindCustomerIterative(Root: in BinarySearchTreePoint; CustomerName: in String10; 	CustomerPoint: out BinarySearchTreePoint) is
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint;
			CustomerName: in string10;
			CustomerPoint: out BinarySearchTreePoint) is
		T : BinarySearchTreePoint;
	begin
		T := Root;
		put_line("FindCustomerIterative");
			loop
				if CustomerName < T.Info.Name and T.LTag then
						T := T.Llink;
				elsif CustomerName > T.info.name and T.RTag then
						T := T.Rlink;
				else
					CustomerPoint := T;
					exit;
				end if;
			end loop;
         put("Info found: ");

		if T.Info.Name = customerName then
			CustomerPoint := T;
      -- else
        --put_line("Record not found!");
      end if;
	end FindCustomerIterative;

	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; CustomerName:  in string10; CustomerPoint:  out BinarySearchTreePoint) is
		T : BinarySearchTreePoint := Root;
	begin
		put_line("FindCustomerRecursive");
		if customerName = T.info.name then
			CustomerPoint := T;
		elsif CustomerName > T.Info.name and T.RTag then
         FindCustomerRecursive(T.RLink, CustomerName, CustomerPoint);
      elsif CustomerName < T.Info.name and T.LTag then
         FindCustomerRecursive(T.LLink, CustomerName, CustomerPoint);
      else
			put("Info found: ");
			CustomerPoint := T;
      end if;


	end FindCustomerRecursive;

	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint)  return BinarySearchTreePoint is
		package stacks is new gstack(50, BinarySearchTreePoint);
		T : BinarySearchTreePoint := TreePoint;
		R : BinarySearchTreePoint;
	begin
		if T /= null then
			if t.ltag then
				T := T.Llink;
				while T.LTag loop
					stacks.push(T);
					T := T.LLink;
				end loop;
			else
				T := T.RLink;
			end if;

      return T;
		end if;
		return null;
	end InOrderSuccessor;


	procedure allocateNode(T: out BinarySearchTreePoint; custname: in string10; custphone: in string10) is
	begin
      T := new Node;
		T.info.name := custname;
		T.info.number := custphone;
		T.LLink := Null;
		T.RLink := Null;
		T.RTag := false;
		T.LTag := false;
	end allocateNode;


	procedure insertNode(P: BinarySearchTreePoint; T: BinarySearchTreePoint; custname: in string10; custphone: in string10) is
	begin
		-- put_line("Insert Node");
		if custName < p.info.name then
			p.Llink := T;
		else
			p.Rlink := T;
		end if;
	end insertNode;


	procedure pushRecord(Info: in string10)is
	begin
		put_line("Put Record");
	end pushRecord;


	function customerName(treePoint : in binarySearchTreePoint) return string10 is
	begin
		return treePoint.info.name;
	end customerName;

	function customerPhone(treePoint : in binarySearchTreePoint) return string10 is
	begin
		return treePoint.info.number;
	end customerPhone;


	procedure main is
	begin
		put_line("MAIN");
	end main;

end BST_Template;