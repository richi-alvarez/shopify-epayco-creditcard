import { authenticate } from '~/shopify.server';

export async function loader({ request }) {
  console.log("auth_bigining.");
  await authenticate.admin(request);
  return null;
}

