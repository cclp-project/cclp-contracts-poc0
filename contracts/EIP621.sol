pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

import "./EIP621Abstract.sol";

contract EIP621 is EIP621Abstract {
    using SafeMath for uint256;

    function EIP621(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol
    ) EIP20(
        _initialAmount,
        _tokenName,
        _decimalUnits,
        _tokenSymbol
    ) public
    {}

    function increaseSupply(uint value, address to) public {
        totalSupply = totalSupply.add(value);
        balances[to] = balances[to].add(value);

        emit Transfer(0, to, value);
    }

    function decreaseSupply(uint value, address from) public {
        balances[from] = balances[from].sub(value);
        totalSupply = totalSupply.sub(value);

        emit Transfer(from, 0, value);
    }
}
