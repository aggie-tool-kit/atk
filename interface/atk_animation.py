from pyfiglet import Figlet

from asciimatics.effects import Scroll, Mirage, Wipe, Cycle, Matrix, BannerText, Stars, Print
from asciimatics.particles import DropScreen
from asciimatics.renderers import FigletText, SpeechBubble, Rainbow, Fire
from asciimatics.scene import Scene
from asciimatics.screen import Screen
from asciimatics.exceptions import ResizeScreenError
import sys


def _credits(screen):
    scenes = []

    text = Figlet(font="banner", width=200).renderText("ATK")
    width = max([len(x) for x in text.split("\n")])

    effects = [
        Matrix(screen, stop_frame=200),
        Mirage(
            screen,
            FigletText("ATK"),
            screen.height // 2 - 3,
            Screen.COLOUR_GREEN,
            start_frame=100,
            stop_frame=200),
        Wipe(screen, start_frame=150),
        Cycle(
            screen,
            FigletText("ATK"),
            screen.height // 2 - 3,
            start_frame=200)
    ]
    scenes.append(Scene(effects, 250, clear=False))

    screen.play(scenes, stop_on_resize=True, repeat=False)


if __name__ == "__main__":
    while True:
        try:
            Screen.wrapper(_credits)
            sys.exit(0)
        except ResizeScreenError:
            pass