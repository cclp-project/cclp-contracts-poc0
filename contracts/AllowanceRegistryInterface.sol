pragma solidity 0.4.21;


contract AllowanceRegistryInterface {
    function isAllowed(address _user) public returns(bool _isAllowed);
}
