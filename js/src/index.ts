import { getKeyPairFromMnemonic } from 'human-crypto-keys';

async function pkcs8ToJwk (key: BufferSource) {
	const imported = await window.crypto.subtle.importKey('pkcs8', key, { name: 'RSA-PSS', hash: 'SHA-256' }, true, ['sign'])
	const jwk = await window.crypto.subtle.exportKey('jwk', imported)
	delete jwk.key_ops
	delete jwk.alg
	return jwk
}

export const generateJWKStringFromMnemonic = async (mnemonic: string) => {
   const keyPair = await getKeyPairFromMnemonic(mnemonic, { id: 'rsa', modulusLength: 4096 }, { privateKeyFormat: 'pkcs8-der' });
   const jwk = await pkcs8ToJwk(keyPair.privateKey as unknown as Uint8Array);
   return JSON.stringify(jwk);
};;

export default generateJWKStringFromMnemonic;
