pragma solidity 0.4.21;


/// @title Contract that supports the receival of EIP223 tokens.
contract EIP223ReceivingContractInterface {
        /// @dev Standard EIP223 function that will handle incoming token transfers.
        /// @param _from  Token sender address.
        /// @param _value Amount of tokens.
        /// @param _data  Transaction metadata.
        function tokenFallback(address _from, uint _value, bytes _data) public;
}