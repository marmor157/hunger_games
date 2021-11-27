#!/usr/bin/env node

const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");
const { generate } = require("@graphql-codegen/cli");

const BASE_DIR = path.dirname(__dirname);

async function runGenerator(config) {
  await generate(
    {
      ...config,
      overwrite: true,
      documents: path.join(BASE_DIR, "src/**/*.graphql"),
      generates: {
        [path.join(BASE_DIR, "src/graphql/index.ts")]: {
          plugins: [
            "typescript",
            "typescript-operations",
            "typescript-react-apollo",
          ],
          scalars: {
            DateTime: "string",
            Date: "string",
          },
        },
      },
      hooks: {
        afterAllFileWrite: ["eslint --fix", "prettier --write"],
      },
    },
    true
  );
}

async function withRemoteSchema(config, f) {
  const schema = "http://localhost:4000/api/v1/";
  await f({ ...config, schema });
}

async function withLocalSchema(config, f) {
  const schema = "/tmp/graphql.schema.json";

  try {
    spawnSync("mix", ["absinthe.schema.json", schema], {
      cwd: path.dirname(BASE_DIR),
      stdio: "inherit",
    });

    await f({ ...config, schema });
  } finally {
    try {
      fs.unlinkSync(schema);
    } catch (e) {
      // ignore
    }
  }
}

function getSchemaSelector(arg) {
  switch (arg) {
    case "remote":
    case "server":
    case undefined:
      return withRemoteSchema;
    case "local":
      return withLocalSchema;
    default:
      throw new Error(`unknown schema selector '${arg}'`);
  }
}

async function main() {
  const schemaSelector = getSchemaSelector(process.argv[2]);

  const config = {
    watch: process.argv.includes("watch") && [
      "../../lib/hunger_games/schema.ex",
      "../../lib/hunger_games/schema/**/*",
    ],
  };

  await schemaSelector(config, runGenerator);
}

main().catch((e) => console.error("Fatal error:", e.message));
