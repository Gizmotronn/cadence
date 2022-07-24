import { RpgEvent, EventData, RpgPlayer } from "@rpgjs/server";

@EventData({
    name: 'EV-1',
    hitbox: {
        width: 32,
        height: 16
    }
})
export class Npc extends RpgEvent {
    onInit() {
        this.setGraphic('female132')
    }
    async onAction(player: RpgPlayer) { // Triggered whe player presses Enter on event
        await player.showText('Hello World!', { // Display a dialogue box to the player
            talkWith: this // character turns to the player when talking
        })
    }
}