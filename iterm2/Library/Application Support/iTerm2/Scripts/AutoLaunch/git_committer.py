
import iterm2
import subprocess
import re
import os

async def main(connection):
    show_domain = "show_domain_only"
    knobs = [iterm2.CheckboxKnob("Show Domain Only", False, show_domain)]
    component = iterm2.StatusBarComponent(
        short_description="Git Committer Email",
        detailed_description="Shows the effective git committer email (respects env vars)",
        knobs=knobs,
        exemplar="user@example.com",
        update_cadence=5,  # Refresh every 5 seconds
        identifier="com.iterm2.example.git-committer-email")

    @iterm2.StatusBarRPC
    async def coro(knobs):
        try:
            result = subprocess.run(
                ['git', 'var', 'GIT_COMMITTER_IDENT'],
                capture_output=True,
                text=True,
                timeout=5,
                env=os.environ.copy()  # This is the key fix!
            )

            if result.returncode == 0:
                ident = result.stdout.strip()
                if ident:
                    email_match = re.search(r'<([^>]+)>', ident)
                    if email_match:
                        email = email_match.group(1)

                        if show_domain in knobs and knobs[show_domain]:
                            if '@' in email:
                                domain = email.split('@')[1]
                                return f"@{domain}"
                            else:
                                return email
                        else:
                            return email
                    else:
                        return "Invalid git ident"
                else:
                    return "No git ident set"
            else:
                return "Not a git repo"
        except subprocess.TimeoutExpired:
            return "Git timeout"
        except FileNotFoundError:
            return "Git not found"
        except Exception as e:
            return "Git error"

    await component.async_register(connection, coro)

iterm2.run_forever(main)


