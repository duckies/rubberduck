# Rubberduck 🦆

A World of Warcraft addon for and by, Rubbewduck-Illidan. Use at your own peril.

## Future Feature Inspiration

- [Annene](https://github.com/Urtgard/Annene/blob/master/Annene.lua)

  Moving the pet battle frame so it's not glued 5 pixels from the bottom of the screen.

## Development Setup

It's annoying to remember how to symlink across WSL to the Windows filesystem.

```
New-Item -ItemType SymbolicLink -Path "C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\Rubberduck" -Target "\\wsl.localhost\Arch\home\johnny\projects\rubberduck\Rubberduck"
```