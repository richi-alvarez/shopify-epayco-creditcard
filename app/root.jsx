import React from "react";
import {
  Links,
  Link,
  LiveReload,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
  useLoaderData, 
  useRouteError 
} from "@remix-run/react";
import { AppProvider as PolarisAppProvider } from "@shopify/polaris";
//import polarisStyles from "@shopify/polaris/build/esm/styles.css";
import '@shopify/polaris/build/esm/styles.css';
import { boundary } from "@shopify/shopify-app-remix";
import { json } from "@remix-run/node";
import polarisTranslation from "@shopify/polaris/locales/en.json";
 
//export const links = () => [{ rel: "stylesheet", href: polarisStyles }];

export const loader = async ({ request }) => {
  return json({
    //polarisTranslations: require("@shopify/polaris/locales/en.json"),
    polarisTranslations: polarisTranslation,
    apiKey: process.env.SHOPIFY_API_KEY,
  });
}

export function Layout({ children }) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <Meta />
        <Links />
      </head>
      <body>
        {children}
        <ScrollRestoration />
        <LiveReload />
        <Scripts />
      </body>
    </html>
  );
}

export default function App() {
  const { polarisTranslations } = useLoaderData();
  return (
    <>
      <PolarisAppProvider
        i18n={polarisTranslations}
        linkComponent={RemixPolarisLink}
      >
        <Outlet />
      </PolarisAppProvider>
    </>
  );
}

/** @type {any} */
const RemixPolarisLink = React.forwardRef((/** @type {any} */ props, ref) => (
  <Link {...props} to={props.url ?? props.to} ref={ref}>
    {props.children}
  </Link>
));

// Shopify needs Remix to catch some thrown responses, so that their headers are included in the response.
export function ErrorBoundary() {
  return boundary.error(useRouteError());
}

export const headers = (headersArgs) => {
  return boundary.headers(headersArgs);
};
