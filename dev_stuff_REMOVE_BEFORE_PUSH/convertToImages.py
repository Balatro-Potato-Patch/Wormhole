import subprocess, argparse
from pathlib import Path

def pack(exe, src, out_base):
    files = [str(p) for p in Path(src).glob("*.ase*")]
    if not files: return print("No Aseprite files found.")
    
    for scale in [1, 2]:
        dest = Path(out_base) / f"{scale}x"
        dest.mkdir(parents=True, exist_ok=True)
        
        cmd = [exe, "-b", *files, "--sheet-columns", "4", "--sheet-pack"]
        if scale == 2: cmd += ["--scale", "2"]
        subprocess.run([*cmd, "--sheet", str(dest/"spritesheet.png")], check=True)

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("e")
    pack(p.parse_args().e, "./spritesheets", "../assets/acme_corp")