import { json } from "@remix-run/node";

export const loader = async ({ request }) => {
  return json({ ePayco: "success" });
};

