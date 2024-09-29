// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./GameToken.sol";

contract MYVault {
    GameToken public immutable gameToken;

    struct Player {
        uint256 tokenHolding;
        uint256 experience;
        uint256 achievements;
        uint256 victories;
        uint256 explorationsCompleted;
        bool votingPower;
        uint256 level;
        string name;
    }

    uint256 public circulatingTokens;
    mapping(address => Player) public players;
    address[] public playerList;
    
    constructor(address tokenAddress) {
        gameToken = GameToken(tokenAddress);
    }

    // Mint tokens and update circulatingTokens and player holdings
    function _mintTokens(address recipient, uint256 amount) private {
        circulatingTokens += amount;
        players[recipient].tokenHolding += amount;
    }

    // Burn tokens and update circulatingTokens and player holdings
    function _burnTokens(address owner, uint256 amount) private {
        circulatingTokens -= amount;
        players[owner].tokenHolding -= amount;
    }

    // Deposit GameTokens into the vault and mint internal tokens based on deposit
    function depositTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        uint256 vaultBalance = gameToken.balances(address(this));
        uint256 tokensToAdd = (vaultBalance == 0) ? amount : (amount * circulatingTokens) / vaultBalance;

        _mintTokens(msg.sender, tokensToAdd);
        gameToken.transferFrom(msg.sender, address(this), amount);

        updateRanking();
    }

    // Withdraw tokens from the vault by burning internal tokens and transferring GameTokens back
    function withdrawTokens(uint256 amount) external {
        require(players[msg.sender].tokenHolding >= amount, "Insufficient token holding");
        uint256 vaultBalance = gameToken.balances(address(this));
        uint256 amountToWithdraw = (amount * vaultBalance) / circulatingTokens;

        _burnTokens(msg.sender, amount);
        gameToken.transfer(msg.sender, amountToWithdraw);

        updateRanking();
    }

    // Register a new player
    function registerPlayer(string memory playerName, uint256 playerLevel, uint256 initialTokens) external {
        require(bytes(playerName).length > 0, "Player name is required");
        require(players[msg.sender].tokenHolding == 0, "Player already registered");

        players[msg.sender] = Player({
            tokenHolding: initialTokens,
            experience: 0,
            achievements: 0,
            victories: 0,
            explorationsCompleted: 0,
            votingPower: false,
            level: playerLevel,
            name: playerName
        });

        playerList.push(msg.sender);

        _mintTokens(msg.sender, initialTokens);
        updateRanking();
    }

    // Simulate a battle between players
    function battleOpponent(address opponent) external {
        require(players[opponent].tokenHolding > 0, "Opponent lacks tokens");
        require(players[msg.sender].tokenHolding > 0, "You lack tokens to battle");

        bool victory = (block.timestamp % 2 == 0); // Simple random win condition
        if (victory) {
            players[msg.sender].victories++;
            players[msg.sender].experience += 10;
            if (players[msg.sender].experience >= 10) {
                players[msg.sender].votingPower = true;
            }
        }

        updateRanking();
    }

    // Explore and earn a reward
    function explore() external {
        require(players[msg.sender].tokenHolding > 0, "Not enough tokens to explore");

        uint256 explorationReward = 50; // Fixed exploration reward
        players[msg.sender].explorationsCompleted++;
        _mintTokens(msg.sender, explorationReward);

        updateRanking();
    }

    // Purchase an item with tokens
    function purchaseItem(uint256 itemCost) external {
        require(players[msg.sender].tokenHolding >= itemCost, "Not enough tokens to purchase item");

        _burnTokens(msg.sender, itemCost);
        // Additional logic for item purchasing can be added here
    }

    // Transfer tokens between players
    function transferPlayerTokens(address recipient, uint256 amount) external {
        require(players[msg.sender].tokenHolding >= amount, "Not enough tokens to transfer");
        require(players[recipient].tokenHolding > 0, "Recipient is not registered");

        players[msg.sender].tokenHolding -= amount;
        players[recipient].tokenHolding += amount;
    }

    // View the leaderboard sorted by token holdings and victories
    function viewLeaderboard() external view returns (address[] memory) {
        address[] memory sortedPlayers = new address[](playerList.length);
        for (uint256 i = 0; i < playerList.length; i++) {
            sortedPlayers[i] = playerList[i];
        }

        // Sort players by token holdings and victories
        for (uint256 i = 0; i < sortedPlayers.length; i++) {
            for (uint256 j = i + 1; j < sortedPlayers.length; j++) {
                address playerA = sortedPlayers[i];
                address playerB = sortedPlayers[j];

                if (
                    players[playerA].tokenHolding < players[playerB].tokenHolding ||
                    (players[playerA].tokenHolding == players[playerB].tokenHolding &&
                        players[playerA].victories < players[playerB].victories)
                ) {
                    // Swap positions
                    address temp = sortedPlayers[i];
                    sortedPlayers[i] = sortedPlayers[j];
                    sortedPlayers[j] = temp;
                }
            }
        }

        return sortedPlayers;
    }

    // Get player details by address
    function getPlayer(address playerAddress) external view returns (Player memory) {
        return players[playerAddress];
    }

    // Private function to update the ranking based on token holdings and victories
    function updateRanking() private {
        // Ranking logic can be extended here if needed
    }
}
