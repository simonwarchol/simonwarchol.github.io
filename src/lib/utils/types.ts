import type { Icons } from '.';

export interface Experience {
	title: string;
	link: string;
	teaser: string;

	authors: string;
	period: {
		from: Date;
		to?: Date;
	};
	industry: string;
	journal: string;
	skills: Array<Technology>;
}

export interface Technology {
	name: string;
	logo: string;
	inverted?: boolean;
}

export interface ProjectLink {
	label?: string;
	to: string;
}

export interface Project {
	color: string;
	logo: string;
	name: string;
	type: string;
	description: string;
	technologies: Array<Technology>;
	links: Array<ProjectLink>;
}

export interface Link {
	to: string;
	title: string;
}

export interface SocialLink extends Link {
	icon: Icons;
}

export interface NavMenuItem extends SocialLink {
	active?: boolean;
}

export type SocialMedia = 'github' | 'googlescholar' | 'twitter' | 'orcid' | 'email';

export interface PageParams {
	title: string;
}

export interface HomeParams extends PageParams {
	name: string;
	lastName: string;
	description: string;
	links: Partial<Record<SocialMedia, string>>;
	skills: Array<Technology>;
}

export interface NavBarParams {
	home: string;
	publications: string;
	personal: string;
	career: string;
	resume: string;
	skills: string;
}

export interface PersonalProjectsParams extends PageParams {
	items: Array<Project>;
}

export interface CareerParams extends PageParams {
	items: Array<Experience>;
}

export interface ResumePageParams extends PageParams {
	cv: string;
}

export interface FeaturedSkill {
	technology: Technology;
	description: string;
}

export interface SkillsParams extends PageParams {
	skills: Array<FeaturedSkill>;
}
