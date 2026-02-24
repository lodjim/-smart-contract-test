// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleToken {
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    mapping(address => uint256) public balances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyPositive (uint256 amount) {
        require(amount > 0, "Amount must be greater than zero");
        _;
    }

    modifier onlyEnough (address sender, uint256 amount) {
        require(balances[sender] >= amount, "Insufficient balance");
        _;
    }

    modifier onlyOwnerCan(){
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function mint(address to, uint256 amount) external onlyPositive(amount) onlyOwnerCan() {
        
        balances[to] += amount;
        emit Mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyPositive(amount) onlyEnough(from, amount) onlyOwnerCan() {
        balances[from] -= amount;
        emit Burn(from, amount);
    }
    function transfer(address to, uint256 amount) external onlyPositive(amount) onlyEnough(msg.sender, amount) {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}