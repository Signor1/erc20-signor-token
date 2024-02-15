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

    constructor(string memory _name, string memory _symbol) {
        tokenName = _name;
        tokenSymbol = _symbol;
        owner = msg.sender;
        //mint method
        mint(1000000000000000000000000000000000000);
    }

    // event for logging
    event Transfer(
        address indexed sender,
        address indexed reciever,
        uint256 amount
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );

    function getTokenName() external view returns (string memory) {
        return tokenName;
    }

    function getSymbol() external view returns (string memory) {
        return tokenSymbol;
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    function decimal() external pure returns (uint8) {
        return 18;
    }

    //balance check
    function balanceOf(address _address) external view returns (uint256) {
        return balances[_address];
    }

    function transfer(address _reciever, uint256 _amountOfToken) external {
        require(_reciever != address(0), "Address is not allowed");
        require(msg.sender != address(0), "Address is not allowed");

        require(
            _amountOfToken <= balances[msg.sender],
            "You can't take more than what is avaliable"
        );

        // calculating the 10% of transfer amount
        uint percentageCalc = (_amountOfToken * 10) / 100;

        //sender's balance check
        uint balanceCheck = _amountOfToken + percentageCalc;

        require(
            balances[msg.sender] >= balanceCheck,
            "Not enough balance to run this transaction"
        );

        //burning the percentage calculation
        burn(msg.sender, percentageCalc);

        balances[msg.sender] = balances[msg.sender] - _amountOfToken;

        balances[_reciever] = balances[_reciever] + _amountOfToken;

        emit Transfer(msg.sender, _reciever, _amountOfToken);
    }

    function approve(address _delegate, uint256 _amountOfToken) external {
        require(balances[msg.sender] > _amountOfToken, "Balance is not enough");

        allow[msg.sender][_delegate] = _amountOfToken;

        emit Approval(msg.sender, _delegate, _amountOfToken);
    }

    function allowance(
        address _owner,
        address _delegate
    ) external view returns (uint) {
        return allow[_owner][_delegate];
    }
}
