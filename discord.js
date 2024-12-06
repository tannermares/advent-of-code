const { Client, Intents, GatewayIntentBits } = require('discord.js');
const cron = require('node-cron');

// Replace with your bot token
const BOT_TOKEN = process.env.BOT_TOKEN;
// Replace with your server ID and channel category ID
const GUILD_ID = process.env.GUILD_ID;
const CATEGORY_ID = process.env.CATEGORY_ID;

const client = new Client({
  intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages],
});

client.once('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);

  // Schedule a task to run every day at 9 PM
  cron.schedule('0 21 * * *', async () => {
    const guild = await client.guilds.fetch(GUILD_ID);
    if (!guild) {
      console.error('Guild not found!');
      return;
    }

    const category = guild.channels.cache.get(CATEGORY_ID);
    if (!category || category.type !== 4) { // 4 = Category Channel
      console.error('Category not found or invalid!');
      return;
    }

    // Get the current day of the month
    const currentDay = new Date().getDate();
    const channelName = `day-${currentDay}`;

    // Create the channel
    try {
      const newChannel = await guild.channels.create({
        name: channelName,
        type: 0, // 0 = Text Channel
        parent: CATEGORY_ID,
        topic: `https://adventofcode.com/2024/day/${currentDay}`,
      });

      console.log(`Channel created: ${newChannel.name}`);
    } catch (error) {
      console.error('Error creating channel:', error);
    }
  });

  console.log('Scheduled task initialized.');
});

client.login(BOT_TOKEN);
