pragma solidity^0.4.20;  
//
interface tokenTransfer {
    function transfer(address receiver, uint amount);
    function transferFrom(address _from, address _to, uint256 _value);
    function balanceOf(address receiver) returns(uint256);
}

contract Ownable {
  address public owner;
  bool lock = false;
 
 
    /**
     * 
     */
    function Ownable () public {
        owner = msg.sender;
    }
 
    /**
     * 
     */
    modifier onlyOwner {
        require (msg.sender == owner);
        _;
    }
 
    /**
     * 
     * @param  newOwner address 
     */
    function transferOwnership(address newOwner) onlyOwner public {
        if (newOwner != address(0)) {
        owner = newOwner;
      }
    }
}

contract BebPos is Ownable{

    //
   struct BebUser {
        address customerAddr;//address
        uint256 amount; // 
        uint256 bebtime;//
        //uint256 interest;//
    }
    uint256 Bebamount;//BEB
    uint256 bebTotalAmount;//BEB
    uint256 sumAmount = 0;// 
    uint256 OneMinuteBEB;//1BEB
    tokenTransfer public bebTokenTransfer; // 
    uint8 decimals = 18;
    uint256 OneMinute=1 minutes; //1
    //  
    mapping(address=>BebUser)public BebUsers;
    address[] BebUserArray;//
    //
    event messageBetsGame(address sender,bool isScuccess,string message);
    //BEB 
    function BebPos(address _tokenAddress,uint256 _Bebamount,uint256 _bebTotalAmount,uint256 _OneMinuteBEB){
         bebTokenTransfer = tokenTransfer(_tokenAddress);
         Bebamount=_Bebamount*10**18;//
         bebTotalAmount=_bebTotalAmount*10**18;//BEB
         OneMinuteBEB=_OneMinuteBEB*10**18;//1BEB 
         BebUserArray.push(_tokenAddress);
     }
         // BEB
    function BebDeposit(address _addr,uint256 _value) public{
        //0
       if(BebUsers[msg.sender].amount == 0){
           //20BEB
           if(Bebamount > OneMinuteBEB){
           bebTokenTransfer.transferFrom(_addr,address(address(this)),_value);//BEB
           BebUsers[_addr].customerAddr=_addr;
           BebUsers[_addr].amount=_value;
           BebUsers[_addr].bebtime=now;
           sumAmount+=_value;//
           //
           //addToAddress(msg.sender);//
           messageBetsGame(msg.sender, true,"");
            return;   
           }
           else{
            messageBetsGame(msg.sender, true,",BEB");
            return;   
           }
       }else{
            messageBetsGame(msg.sender, true,",");
            return;
       }
    }

    //
    function redemption() public {
        address _address = msg.sender;
        BebUser storage user = BebUsers[_address];
        require(user.amount > 0);
        //
        uint256 _time=user.bebtime;//
        uint256 _amuont=user.amount;//
           uint256 AA=(now-_time)/OneMinute*OneMinuteBEB;//-/60*20BEB
           uint256 BB=bebTotalAmount-Bebamount;//
           uint256 CC=_amuont*AA/BB;//*AA/
           //20BEB
           if(Bebamount > OneMinuteBEB){
              Bebamount-=CC; 
             //user.interest+=CC;//
             user.bebtime=now;//
           }
        //20BEB
        if(Bebamount > OneMinuteBEB){
            Bebamount-=CC;//
            sumAmount-=_amuont;
            bebTokenTransfer.transfer(msg.sender,CC+user.amount);// + + 
           // 
            BebUsers[_address].amount=0;//0
            BebUsers[_address].bebtime=0;//0
            //BebUsers[_address].interest=0;//0
            messageBetsGame(_address, true,"");
            return;
        }
        else{
            Bebamount-=CC;//
            sumAmount-=_amuont;
            bebTokenTransfer.transfer(msg.sender,_amuont);// +  
           // 
            BebUsers[_address].amount=0;//0
            BebUsers[_address].bebtime=0;//0
            //BebUsers[_address].interest=0;//0
            messageBetsGame(_address, true,"BEB");
            return;  
        }
    }
    function getTokenBalance() public view returns(uint256){
         return bebTokenTransfer.balanceOf(address(this));
    }
    function getSumAmount() public view returns(uint256){
        return sumAmount;
    }
    function getBebAmount() public view returns(uint256){
        return Bebamount;
    }
    function getBebAmountzl() public view returns(uint256){
        uint256 _sumAmount=bebTotalAmount-Bebamount;
        return _sumAmount;
    }

    function getLength() public view returns(uint256){
        return (BebUserArray.length);
    }
     function getUserProfit(address _form) public view returns(address,uint256,uint256,uint256){
       address _address = _form;
       BebUser storage user = BebUsers[_address];
       assert(user.amount > 0);
       uint256 A=(now-user.bebtime)/OneMinute*OneMinuteBEB;
       uint256 B=bebTotalAmount-Bebamount;
       uint256 C=user.amount*A/B;
        return (_address,user.bebtime,user.amount,C);
    }
    function()payable{
        
    }
}