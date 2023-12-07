# Documentation

## Overview

The SoulBondToken smart contract introduces a unique ownership concept for digital tokens. It creates two types of tokens - Soulbound Tokens and Item Tokens. The Soulbound Token is like a special character, and Item Tokens are like accessories or items associated with that character.

### Key Features

- **Soulbound Tokens:**
  - Minted by the contract owner.
  - Each wallet can own only one Soulbound Token.
  - Soulbound Tokens cannot be transferred.

- **Item Tokens:**
  - Minted by the owner of the Soulbound Token.
  - Represent accessories or items.
  - Can be transferred only between addresses with the Soulbound Token.

## Functionality

### Minting a Soulbound Token

To create your unique Soulbound Token:

```bash
# Call this function to mint a Soulbound Token
soulBondToken.mintSoulboundToken(yourWalletAddress)
```

### Minting Item Tokens

Once you own a Soulbound Token, you can create Item Tokens:

```bash
# Mint accessories or items associated with your Soulbound Token
soulBondToken.mintItemTokensToOwner(quantity)
```

### Transferring Item Tokens

Share your Item Tokens with others who own a Soulbound Token:

```bash
# Transfer your accessories or items to another Soulbound Token owner
soulBondToken.transferItemTokens(receiverAddress, quantity)
```

## Deployment

The contract is deployed to sepolia testnet
   ```

