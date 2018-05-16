pragma solidity 0.4.23;


contract AllowanceRegistryInterface {
    function isAllowed(address _user) public view returns(bool _isAllowed);
}
