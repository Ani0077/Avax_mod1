# MYVault Gaming Platform on Ethereum

## Overview

This project is a decentralized gaming platform built on the Ethereum blockchain. The game allows players to engage in various in-game activities like battles, exploration, and purchasing items using a custom token called **AniCoin (AMC)**. Players can earn, deposit, transfer, and withdraw tokens within the platform. The system is fully decentralized, using smart contracts to ensure transparency and fairness in all transactions.

## Features

- **In-Game Currency**: Players use **AniCoin (AMC)**, a custom ERC-20 token, for all in-game transactions.
- **Player Registration**: Players can register with a name, level, and initial token holdings, which sets up their game profiles.
- **Token Management**: Players can deposit and withdraw tokens via a decentralized vault system.
- **Player Interaction**: Players can battle, explore, purchase items, and transfer tokens between each other.
- **Leaderboard**: A dynamic leaderboard ranks players based on their token holdings and battle victories.
- **Voting Power**: Players can earn voting rights based on their in-game experience and achievements.

## Getting Started

### Prerequisites

- **Ethereum Wallet**: You'll need a wallet like Metamask to interact with the Ethereum blockchain.
- **Remix IDE**: Use Remix IDE for writing, compiling, and deploying smart contracts.
- **Ether**: You'll need some Ether in your wallet to cover gas fees for blockchain interactions.

### Step-by-Step Guide

#### 1. Deploy the GameToken Contract

Use the Remix IDE to compile and deploy the `GameToken.sol` contract, which will create **AniCoin (AMC)**, the ERC-20 token used in the game for transactions.

#### 2. Deploy the MYVault Contract

After deploying the `GameToken.sol` contract, compile and deploy the `MYVault.sol` contract. You'll need to provide the address of the `GameToken` contract during the deployment of `MYVault` so that the vault can interact with the token.

#### 3. Register as a Player

Players can register by calling the `registerPlayer` function, providing a player name, initial level, and token deposit. This sets up their profile within the game.

#### 4. Deposit Tokens

Players can deposit **AniCoin** into the vault by calling the `depositTokens` function. This will transfer tokens from the player's wallet to the game vault, increasing their in-game token holdings.

#### 5. Withdraw Tokens

Players can withdraw their tokens from the vault by calling the `withdrawTokens` function. The amount withdrawn is calculated based on the player's share of the vault's total token supply.

#### 6. Battle, Explore, and Purchase Items

Players can participate in in-game activities such as:
- **Battle**: Engage in battles with other players to earn experience points and victories.
- **Explore**: Explore the game environment to collect rewards such as tokens and experience.
- **Purchase Items**: Use tokens to buy in-game items that enhance gameplay.

#### 7. Transfer Tokens

Players can transfer tokens to other registered players using the `transferPlayerTokens` function.

#### 8. View Leaderboard

The contract automatically updates the leaderboard, ranking players based on their token holdings and victories in battles. Players can view the leaderboard by calling the `viewLeaderboard` function.

## Game Mechanics

### Token Management

- **Depositing Tokens**: Players can deposit **AniCoin** into the vault, earning internal tokens that represent their contribution to the total circulating supply.
- **Withdrawing Tokens**: Players can burn their internal tokens to withdraw **AniCoin** from the vault based on their share of the total token balance.

### Player Profile

Each player has a profile that includes:
- **Token Holdings**: The total amount of **AniCoin** a player owns.
- **Experience**: Earned through battles and exploration.
- **Achievements and Victories**: Track the player’s in-game progress.
- **Explorations Completed**: The number of explorations a player has completed.
- **Voting Power**: Players gain voting rights as they accumulate experience.
- **Level**: The player’s current level in the game.
- **Name**: The player’s chosen name.

### Core Game Features

- **Register**: Players can register their profiles by providing a name, initial level, and token balance.
- **Battle**: Players can battle other registered players to earn experience and victories.
- **Explore**: Players can explore the game world to earn rewards such as tokens and experience points.
- **Purchase**: Players can use tokens to purchase in-game items and upgrades.
- **Transfer Tokens**: Players can transfer tokens to other players to engage in player-to-player interactions.

### Leaderboard

The platform maintains a dynamic leaderboard, ranking players based on:
- **Token Holdings**: The total tokens a player holds.
- **Victories**: The number of battles won by the player.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

---

**Author**: [Aniket Tiwari]
