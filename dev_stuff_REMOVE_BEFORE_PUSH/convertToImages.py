import subprocess, argparse
from pathlib import Path

def pack(exe, src, out):
    i_path = Path(src)
    o1, o2 = Path(out)/"1x", Path(out)/"2x"
    o1.mkdir(parents=True, exist_ok=True); o2.mkdir(parents=True, exist_ok=True)
    
    f = [str(p) for p in i_path.glob("*.ase*")]
    if not f: return print("No Aseprite files.")
    
    cmd = [exe, "-b", *f, "--sheet-columns", "4", "--sheet-pack"]
    subprocess.run([*cmd, "--sheet", str(o1/"spritesheet.png")], check=True)
    subprocess.run([*cmd, "--scale", "2", "--sheet", str(o2/"spritesheet.png")], check=True)

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("e")
    pack(p.parse_args().e, "./spritesheets", "../assets")