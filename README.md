# infra

## Outline and dex

```sh
cp dex/.env.example dex/.env
cp outline/.env.example outline/.env
```

### `dex/.env`

| Variable | Value |
| --- | --- |
| `GITHUB_CLIENT_ID` | From a [swat-ksu GitHub OAuth app](https://github.com/organizations/swat-ksu/settings/applications) with callback `http://localhost:5556/callback` |
| `GITHUB_CLIENT_SECRET` | Click `Generate a new client secret` on the same page from above | 
| `OIDC_CLIENT_SECRET` | `openssl rand -hex 32` |

### `outline/.env`

| Variable | Value |
| --- | --- |
| `URL` | `http://localhost:3000` |
| `SECRET_KEY` | `openssl rand -hex 32` |
| `UTILS_SECRET` | `openssl rand -hex 32` |
| `OIDC_CLIENT_ID` | `outline` |
| `OIDC_CLIENT_SECRET` | Same as `dex/.env` |
| `OIDC_AUTH_URI` | `http://localhost:5556/auth` |
| `OIDC_TOKEN_URI` | `http://dex:5556/token` |
| `OIDC_USERINFO_URI` | `http://dex:5556/userinfo` |

localhost addresses for local testing only. Once tested in production, update as follows:

- `https://dex.skeary.me` for all three `OIDC_*_URI` values
- `https://outline.skeary.me` for `URL`
- update the URLs in `dex/config.yml` and the OAuth app callback to match.


> **Watch out:**
> 
> Remember to set `FORCE-HTTPS` to `false` when testing locally and `true` when in production

> **Watch out:** (#2) *only observed on linux*
>
> dex requires access to data/dex. First create data/dex and then grant perms to access to uid 1001 (dex's uid in docker):
>
> ```sh
> mkdir data/dex
> sudo chown 1001:1001 data/dex
> ```