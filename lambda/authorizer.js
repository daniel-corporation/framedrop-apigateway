const { CognitoJwtVerifier } = require("aws-jwt-verify");

const verifier = CognitoJwtVerifier.create({
  userPoolId: process.env.USER_POOL_ID,
  tokenUse: "access",
  clientId: process.env.CLIENT_ID,
});

exports.handler = async (event) => {
  const token = event.authorizationToken.replace("Bearer ", "");

  try {
    const payload = await verifier.verify(token);
    console.log("Token válido:", payload);
    return generatePolicy("user", "Allow", event.methodArn);
  } catch (err) {
    console.error("Token inválido:", err);
    return generatePolicy("user", "Deny", event.methodArn);
  }
};

const generatePolicy = (principalId, effect, resource) => {
  const authResponse = { principalId };
  if (effect && resource) {
    authResponse.policyDocument = {
      Version: "2012-10-17",
      Statement: [
        {
          Action: "execute-api:Invoke",
          Effect: effect,
          Resource: resource,
        },
      ],
    };
  }
  return authResponse;
};