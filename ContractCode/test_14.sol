contract A{
	uint public a = 1;
	function add(uint _a) public returns(uint){
		a = a + _a;
		}
	function judge() public returns(bool){if(a == 1){return true;}return false;}
}

            
            
