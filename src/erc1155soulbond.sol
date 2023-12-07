// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// forge script script/deploy.s.sol:DeployNft --rpc-url $rpc --broadcast --verify -vvvv
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract soulBondToken is ERC1155, Ownable {
    constructor(address initialOwner, string memory uri) ERC1155(uri) Ownable(initialOwner){
        transferOwnership(initialOwner);
        // mintSoulboundToken(initialOwner, 1);

    }





    // Mapping to track the owner of the soulbound main token address --> token id
    mapping(address => uint256) private soulboundTokenOwners;

    // Event emitted when a soulbound main token is minted
    event SoulboundTokenMinted(address indexed owner, uint256 tokenId);

    // Modifier to ensure that an action can only be performed by the owner of the soulbound main token
    modifier onlySoulboundTokenOwner(uint256 _tokenId) {
        require(soulboundTokenOwners[msg.sender] == _tokenId, "Not the owner of the soulbound token");
        _;
    }


    // Mint a soulbound main token. Can only be called by the contract owner.
    function mintSoulboundToken(address _owner, uint256 _tokenId) public onlyOwner {
        require(soulboundTokenOwners[_owner] == 0, "Owner already has a soulbound token");

        // Mint the soulbound main token to the specified owner
        _mint(_owner, _tokenId, 1, "");

        // Mark the owner as the owner of a soulbound token
        soulboundTokenOwners[_owner] = _tokenId;

        // Emit an event
        emit SoulboundTokenMinted(_owner, _tokenId);
    }

    // Mint item tokens (fractional ERC20-like tokens) to the owner.
    // Can only be called by the owner of the soulbound main token.
    function mintItemTokensToOwner(uint256 _tokenId, uint256 _quantity) external onlySoulboundTokenOwner(_tokenId) {
        // Mint the item tokens to the owner
        _mint(msg.sender, _tokenId, _quantity, "");
    }

    // Transfer item tokens between addresses with the soulbound main token.
    // Can only be called by the owner of the soulbound main token.
    function transferItemTokens(
        address _to,
        uint256 _tokenId,
        uint256 _quantity,
        bytes memory _data
    ) external onlySoulboundTokenOwner(soulboundTokenOwners[msg.sender]) {
        // Transfer the item tokens
        safeTransferFrom(msg.sender, _to, _tokenId, _quantity, _data);
    }

    // Function to check if a wallet owns the soulbound main token
    function getSoulboundTokenOwner(address _wallet) external view returns (uint256) {
        return soulboundTokenOwners[_wallet];
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) public override virtual onlySoulboundTokenOwner(soulboundTokenOwners[msg.sender])  {
        address sender = _msgSender();
        if (from != sender && !isApprovedForAll(from, sender)) {
            revert ERC1155MissingApprovalForAll(sender, from);
        }
        _safeBatchTransferFrom(from, to, ids, values, data);
    }
    function safeTransferFrom(address from, address to, uint256 id, uint256 value, bytes memory data) override onlySoulboundTokenOwner(soulboundTokenOwners[msg.sender])  public virtual {
        address sender = _msgSender();
        if (from != sender && !isApprovedForAll(from, sender)) {
            revert ERC1155MissingApprovalForAll(sender, from);
        }
        _safeTransferFrom(from, to, id, value, data);
    }






}


