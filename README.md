# CTIA Guided Lab — unconstrained-delegation-001

**Unconstrained Kerberos delegation and pass-the-ticket detection.**

You are the analyst. A SOC ticket says there is a suspected delegation abuse on
the workstation subnet `10.0.4.0/24`, with privileged sessions appearing on
servers that nobody was logged in to. Five log exports are waiting for you. Work
out exactly what happened, which account was stolen, which machines are actually
compromised, and what you would contain first.

Everything runs in a **real bash shell** inside this repository, against the real
log files — every command you click or type is executed for real.

---

## 1 · What you need

| | |
|---|---|
| Host | VirtualBox (or VMware) |
| Guest | Kali Linux VM, powered on and logged in |
| Inside Kali | `git` and `python3` — both ship with Kali |

Check them in the Kali terminal:

```bash
git --version
python3 --version
```

If either is missing:

```bash
sudo apt update && sudo apt install -y git python3
```

> You do **not** need to change any VirtualBox network settings. The lab listens
> only on `127.0.0.1` **inside** the VM, so NAT, bridged and host-only all work
> the same. You also do not need to forward any ports. This is the single most
> common thing students get wrong, so read it twice.

---

## 2 · Get the lab

In the Kali terminal:

```bash
cd ~
git clone https://github.com/CE47/unconstrained-delegation-001.git
cd unconstrained-delegation-001
```

Confirm the evidence arrived — you should see `7456 total`:

```bash
wc -l *.log | tail -1
```

---

## 3 · Start the lab

```bash
./start-lab.sh
```

> If you see `Permission denied`, run `bash start-lab.sh` instead.

The terminal prints the address to open, and Firefox opens on its own:

```
http://127.0.0.1:8777/
```

If the browser does not open, type that address into **Firefox inside Kali**.
(Use the browser in the VM, not the one on your host machine.)

---

## 4 · Check you are ready

Look at the pill in the top-right of the page:

| Pill | Meaning |
|---|---|
| **Live** (green) | Connected to the real bash shell — you are ready. |
| **Searching** / **Offline** | The server is not running yet — see Troubleshooting. |

The page finds the shell by itself, so if you start the lab later it connects
without you refreshing. The terminal at the bottom of the page is a real shell —
type in it or press **Run** on any command.

---

## 5 · Work the lab

1. Move through the **18 steps** with **Back / Next**, or the arrow keys.
2. Press **Run** on a command to execute it in the real terminal; **Copy** puts it
   on your clipboard. Run a whole ladder from the top box and watch the output
   change as each tool is added — the derivation is the lesson, so do not skip
   ahead.
3. Type your own commands in the terminal whenever you want to explore further.
4. Answer every **checkpoint** at the end of each step — think before running.
5. Use the **analyst notes** box at the bottom of each step; they save
   automatically and are included in your report.
6. On the last step, fill in the report, press **Check my answers**, then
   **Export PDF report** and choose *Save as PDF* in the print dialog.

Three things worth knowing before you start:

- **Hostname numbers do not match addresses in this estate.** `sec-win-04` is
  `10.0.4.12`, not `10.0.4.4`. Resolve addresses through `dhcp_leases.log`; never
  guess.
- **A count is not a finding.** A privileged-looking account reaching three
  servers looks alarming and is not the answer. What matters is *how* each
  session arrived, and whether anyone was ever at a keyboard.
- **"Used" and "compromised" are different words.** Three servers received a
  stolen session; work actually happened on only one of them. Keeping those apart
  is the difference between a containment list of one machine and an island of
  four, and it is worth marks.

**Do not edit the `.log` files** — they are your evidence.

---

## 6 · When you are done

Press **Ctrl+C** in the terminal where you started the lab. That stops the server.

To work on the lab again later:

```bash
cd ~/unconstrained-delegation-001
./start-lab.sh
```

---

## Troubleshooting

**The pill says Offline / Searching**
The lab server is not running. Open a second terminal,
`cd ~/unconstrained-delegation-001` and run `./start-lab.sh` — the page connects
by itself when it starts.

**Firefox did not open**
Open Firefox in Kali and go to the address printed in the terminal.

**The page shows nothing / 404**
You opened the wrong URL. Use the one printed in the terminal, including
`http://` and the port number.

**`Address already in use`**
Something else is on port 8777. Either close it, or pick another port:

```bash
./start-lab.sh 9000      # then open http://127.0.0.1:9000/
```

**`python3: command not found`**

```bash
sudo apt update && sudo apt install -y python3
```

**`Permission denied` on `./start-lab.sh`**

```bash
bash start-lab.sh
```

**A command printed nothing and the page looked stuck**
Scroll the terminal dock up — output is there, the dock just holds the last screen
full. Press **Ctrl+L** in the terminal to clear it. Some commands in this lab
legitimately print nothing: a count of zero is a result, not a failure.

**I want to view the lab from my host browser instead**
Stop the lab, add a VirtualBox port forward (host `8777` → guest `8777`), and run
`./start-lab.sh --no-open`. Viewing it in Kali is the supported path and needs no
configuration.

**Before you start**
If you want a clean slate to return to, take a VirtualBox snapshot now — the lab
stores nothing outside this folder, so reverting a snapshot also resets it.

---

## What you are submitting

One PDF from **Export PDF report** on the final step, containing:

- your answers to Q1–Q24,
- the self-check marks,
- your two written answers (Q25 narrative, Q26 recommendations),
- your analyst notes,
- the list of commands you actually ran,
- a grading block for your instructor.

Name the file `unconstrained-delegation-001_<your-name>.pdf`.