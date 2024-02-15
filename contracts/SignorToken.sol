// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SignorToken {
    //the state variables
    string tokenName;
    string tokenSymbol;
    uint256 totalSupply;
    address owner;

    //making an amount tracable by address
    mapping(address user => uint256) balances;
    //making an amount tracable by address A and address A traced by address B
    //key => (key => value)
    mapping(address => mapping(address => uint256)) allow;
}
