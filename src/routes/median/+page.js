import { error } from '@sveltejs/kit';
// @ts-ignore
export async function load({}) {
	// Make a request to https://hfeuutqssj.execute-api.us-east-1.amazonaws.com/prod/median
	// and return the response as `data`
	// See https://kit.svelte.dev/docs#loading
	const data = await fetch('https://hfeuutqssj.execute-api.us-east-1.amazonaws.com/prod/median');
	if (data.ok) {
		return await data.json();
	}
	throw error(404, 'Not found');
}
