import { Signer } from "ethers";
import { keccak256, toUtf8Bytes } from "ethers/lib/utils";

// Note!: It's quite important to have the deterministic version of ECDSA
// Signatures here. Looks like ethereum uses the deterministic version of
// ECDSA: https://ethereum.stackexchange.com/a/66240
// But it will be a good practice to also back up a generated salt in
// local storage and maybe even display it to a user
export const generateSaltForVote = async (
  disputeId: number,
  signer: Signer
): Promise<string> => {
  const seedMessage = toUtf8Bytes(disputeId + "REDSTONE_DISPUTE_SALT");
  const signature = await signer.signMessage(seedMessage);
  const salt = keccak256(signature);
  return salt;
};
