# infra

## Setup

```sh
cp dex/.env.example dex/.env
cp outline/.env.example outline/.env
```

### `dex/.env`

Create a [swat-ksu GitHub OAuth app](https://github.com/organizations/swat-ksu/settings/applications). In "Redirect URIs", set `http://localhost:5556/callback` for testing and `https://dex.${DOMAIN}/callback` (substituted) for production. Copy "Client ID" and create a "Client Secret".

| Variable               | Value                            |
| ---------------------- | -------------------------------- |
| `GITHUB_CLIENT_ID`     | GitHub OAuth app "Client ID"     |
| `GITHUB_CLIENT_SECRET` | GitHub OAuth app "Client Secret" |
| `OIDC_CLIENT_SECRET`   | `openssl rand -hex 32`           |

### `outline/.env`

| Variable             | Value                             |
| -------------------- | --------------------------------- |
| `URL`                | `http://localhost:3000`           |
| `SECRET_KEY`         | `openssl rand -hex 32`            |
| `UTILS_SECRET`       | `openssl rand -hex 32`            |
| `OIDC_CLIENT_ID`     | `outline`                         |
| `OIDC_CLIENT_SECRET` | `dex/.env`'s `OIDC_CLIENT_SECRET` |
| `OIDC_AUTH_URI`      | `http://localhost:5556/auth`      |
| `OIDC_TOKEN_URI`     | `http://dex:5556/token`           |
| `OIDC_USERINFO_URI`  | `http://dex:5556/userinfo`        |

Once in production, update as follows:

- `https://dex.skeary.me` in Outline's `OIDC_AUTH_URI`, `OIDC_TOKEN_URI`, `OIDC_USERINFO_URI`.
- `https://outline.skeary.me` in Outline's `URL`.
- Update the URLs in `dex/config.yml`.

## Warnings

- Remember to set `FORCE-HTTPS` to `false` when testing locally and `true` when in production
- (On Linux) Dex requires access to `data/dex`. Create `data/dex` and then grant perms to access to uid 1001 (Dex's uid in Docker):
  ```bash
  mkdir data/dex
  sudo chown 1001:1001 data/dex
  ```
