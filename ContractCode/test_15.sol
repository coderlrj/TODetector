contract MarketPalce{
	uint256 public price;
	uint256 public stock;
	address public owner;
	function updateprice(uint _price) public
	{
		if(msg.sender == owner)
		{
			price = _price;
		}
	}
	function buy(uint quant) public
	{
		if(msg.value < quant * price )
		{ throw;}
		stock = stock - quant;
	}
}
