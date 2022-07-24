import { RpgMap, MapData } from '@rpgjs/server';
import { VillagerEvent } from '../events/villager';
import { Npc } from '../events/npc';

@MapData({
    id: 'simplemap',
    file: require('./tmx/simplemap.tmx'),
    name: 'Forest',
    events: [
        VillagerEvent,
        Npc
    ]
})
export class SampleMap extends RpgMap {}