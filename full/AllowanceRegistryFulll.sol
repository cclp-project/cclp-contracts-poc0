pragma solidity 0.4.21;

// File: contracts/AllowanceRegistryInterface.sol

contract AllowanceRegistryInterface {
    function isAllowed(address _user) public view returns(bool _isAllowed);
}

// File: zeppelin-solidity/contracts/ownership/Ownable.sol

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

// File: contracts/AllowanceRegistry.sol

contract AllowanceRegistry is AllowanceRegistryInterface, Ownable {

    mapping (address => bool) public registrars;
    mapping (address => bool) public allowed;

    modifier onlyRegistrar {
        require(registrars[msg.sender]);
        _;
    }

    function AllowanceRegistry() public
    {}

    function setRegistrar(address _registar, bool _value) public onlyOwner {
        registrars[_registar] =_value;
    }

    function allowUser(address _user) public onlyRegistrar {
        allowed[_user] = true;
        emit Allow(msg.sender, _user, now);
    }

    function denyUser(address _user) public onlyRegistrar {
        allowed[_user] = false;
        emit Deny(msg.sender, _user, now);
    }


    function isAllowed(address _user) public view returns(bool _isAllowed){
        return allowed[_user];
    }

    event Allow(address indexed _registar, address indexed _user, uint256 _timestamp);
    event Deny (address indexed _registar, address indexed _user, uint256 _timestamp);


}