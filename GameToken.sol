// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GameToken {

    uint public totalTokens;
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowed;
    
    string public tokenName = "AniCoin";
    string public tokenSymbol = "AMC";
    uint8 public tokenDecimals = 18;

    event Transfer(address indexed sender, address indexed receiver, uint amount);
    event Approval(address indexed owner, address indexed delegate, uint amount);

    function transfer(address recipient, uint amount) external returns (bool) {
        uint senderBalance = balances[msg.sender];
        require(senderBalance >= amount, "Insufficient balance");
        
        unchecked {
            balances[msg.sender] = senderBalance - amount;
        }
        balances[recipient] += amount;
        
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address delegate, uint amount) external returns (bool) {
        allowed[msg.sender][delegate] = amount;
        
        emit Approval(msg.sender, delegate, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        uint senderBalance = balances[sender];
        uint allowanceAmount = allowed[sender][msg.sender];
        
        require(senderBalance >= amount, "Insufficient balance");
        require(allowanceAmount >= amount, "Allowance exceeded");
        
        unchecked {
            allowed[sender][msg.sender] = allowanceAmount - amount;
            balances[sender] = senderBalance - amount;
        }
        balances[recipient] += amount;
        
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        uint currentSupply = totalTokens;
        uint newSupply = currentSupply + amount;
        
        balances[msg.sender] += amount;
        totalTokens = newSupply;
        
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        uint senderBalance = balances[msg.sender];
        require(senderBalance >= amount, "Insufficient balance");
        
        unchecked {
            balances[msg.sender] = senderBalance - amount;
        }
        totalTokens -= amount;
        
        emit Transfer(msg.sender, address(0), amount);
    }
}
