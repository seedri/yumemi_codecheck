import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_codecheck/data/repository.dart';

void main() {
  // https://api.github.com/search/repositories
  String jsonData = '''
 {
  "total_count": 4,
  "incomplete_results": false,
  "items": [
    {
      "id": 738265574,
      "node_id": "R_kgDOLAEJ5g",
      "name": "Unity24",
      "full_name": "mjwg/Unity24",
      "private": false,
      "owner": {
        "login": "mjwg",
        "id": 74848706,
        "node_id": "MDQ6VXNlcjc0ODQ4NzA2",
        "avatar_url": "https://avatars.githubusercontent.com/u/74848706?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/mjwg",
        "html_url": "https://github.com/mjwg",
        "followers_url": "https://api.github.com/users/mjwg/followers",
        "following_url": "https://api.github.com/users/mjwg/following{/other_user}",
        "gists_url": "https://api.github.com/users/mjwg/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/mjwg/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/mjwg/subscriptions",
        "organizations_url": "https://api.github.com/users/mjwg/orgs",
        "repos_url": "https://api.github.com/users/mjwg/repos",
        "events_url": "https://api.github.com/users/mjwg/events{/privacy}",
        "received_events_url": "https://api.github.com/users/mjwg/received_events",
        "type": "User",
        "site_admin": false
      },
      "html_url": "https://github.com/mjwg/Unity24",
      "description": "All my Unity games from 2024!!! Everything in here is intellectual property of me, this is **NOT** public domain.",
      "fork": false,
      "url": "https://api.github.com/repos/mjwg/Unity24",
      "forks_url": "https://api.github.com/repos/mjwg/Unity24/forks",
      "keys_url": "https://api.github.com/repos/mjwg/Unity24/keys{/key_id}",
      "collaborators_url": "https://api.github.com/repos/mjwg/Unity24/collaborators{/collaborator}",
      "teams_url": "https://api.github.com/repos/mjwg/Unity24/teams",
      "hooks_url": "https://api.github.com/repos/mjwg/Unity24/hooks",
      "issue_events_url": "https://api.github.com/repos/mjwg/Unity24/issues/events{/number}",
      "events_url": "https://api.github.com/repos/mjwg/Unity24/events",
      "assignees_url": "https://api.github.com/repos/mjwg/Unity24/assignees{/user}",
      "branches_url": "https://api.github.com/repos/mjwg/Unity24/branches{/branch}",
      "tags_url": "https://api.github.com/repos/mjwg/Unity24/tags",
      "blobs_url": "https://api.github.com/repos/mjwg/Unity24/git/blobs{/sha}",
      "git_tags_url": "https://api.github.com/repos/mjwg/Unity24/git/tags{/sha}",
      "git_refs_url": "https://api.github.com/repos/mjwg/Unity24/git/refs{/sha}",
      "trees_url": "https://api.github.com/repos/mjwg/Unity24/git/trees{/sha}",
      "statuses_url": "https://api.github.com/repos/mjwg/Unity24/statuses/{sha}",
      "languages_url": "https://api.github.com/repos/mjwg/Unity24/languages",
      "stargazers_url": "https://api.github.com/repos/mjwg/Unity24/stargazers",
      "contributors_url": "https://api.github.com/repos/mjwg/Unity24/contributors",
      "subscribers_url": "https://api.github.com/repos/mjwg/Unity24/subscribers",
      "subscription_url": "https://api.github.com/repos/mjwg/Unity24/subscription",
      "commits_url": "https://api.github.com/repos/mjwg/Unity24/commits{/sha}",
      "git_commits_url": "https://api.github.com/repos/mjwg/Unity24/git/commits{/sha}",
      "comments_url": "https://api.github.com/repos/mjwg/Unity24/comments{/number}",
      "issue_comment_url": "https://api.github.com/repos/mjwg/Unity24/issues/comments{/number}",
      "contents_url": "https://api.github.com/repos/mjwg/Unity24/contents/{+path}",
      "compare_url": "https://api.github.com/repos/mjwg/Unity24/compare/{base}...{head}",
      "merges_url": "https://api.github.com/repos/mjwg/Unity24/merges",
      "archive_url": "https://api.github.com/repos/mjwg/Unity24/{archive_format}{/ref}",
      "downloads_url": "https://api.github.com/repos/mjwg/Unity24/downloads",
      "issues_url": "https://api.github.com/repos/mjwg/Unity24/issues{/number}",
      "pulls_url": "https://api.github.com/repos/mjwg/Unity24/pulls{/number}",
      "milestones_url": "https://api.github.com/repos/mjwg/Unity24/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/mjwg/Unity24/notifications{?since,all,participating}",
      "labels_url": "https://api.github.com/repos/mjwg/Unity24/labels{/name}",
      "releases_url": "https://api.github.com/repos/mjwg/Unity24/releases{/id}",
      "deployments_url": "https://api.github.com/repos/mjwg/Unity24/deployments",
      "created_at": "2024-01-02T20:35:34Z",
      "updated_at": "2024-01-02T20:35:35Z",
      "pushed_at": "2024-01-02T20:35:35Z",
      "git_url": "git://github.com/mjwg/Unity24.git",
      "ssh_url": "git@github.com:mjwg/Unity24.git",
      "clone_url": "https://github.com/mjwg/Unity24.git",
      "svn_url": "https://github.com/mjwg/Unity24",
      "homepage": null,
      "size": 0,
      "stargazers_count": 0,
      "watchers_count": 0,
      "language": null,
      "has_issues": true,
      "has_projects": true,
      "has_downloads": true,
      "has_wiki": true,
      "has_pages": false,
      "has_discussions": false,
      "forks_count": 0,
      "mirror_url": null,
      "archived": false,
      "disabled": false,
      "open_issues_count": 0,
      "license": null,
      "allow_forking": true,
      "is_template": false,
      "web_commit_signoff_required": false,
      "topics": [
      ],
      "visibility": "public",
      "forks": 0,
      "open_issues": 0,
      "watchers": 0,
      "default_branch": "main",
      "score": 1.0
    },
    {
      "id": 704984087,
      "node_id": "R_kgDOKgU0Fw",
      "name": "unity24",
      "full_name": "risaevent/unity24",
      "private": false,
      "owner": {
        "login": "risaevent",
        "id": 147941764,
        "node_id": "O_kgDOCNFphA",
        "avatar_url": "https://avatars.githubusercontent.com/u/147941764?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/risaevent",
        "html_url": "https://github.com/risaevent",
        "followers_url": "https://api.github.com/users/risaevent/followers",
        "following_url": "https://api.github.com/users/risaevent/following{/other_user}",
        "gists_url": "https://api.github.com/users/risaevent/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/risaevent/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/risaevent/subscriptions",
        "organizations_url": "https://api.github.com/users/risaevent/orgs",
        "repos_url": "https://api.github.com/users/risaevent/repos",
        "events_url": "https://api.github.com/users/risaevent/events{/privacy}",
        "received_events_url": "https://api.github.com/users/risaevent/received_events",
        "type": "Organization",
        "site_admin": false
      },
      "html_url": "https://github.com/risaevent/unity24",
      "description": null,
      "fork": false,
      "url": "https://api.github.com/repos/risaevent/unity24",
      "forks_url": "https://api.github.com/repos/risaevent/unity24/forks",
      "keys_url": "https://api.github.com/repos/risaevent/unity24/keys{/key_id}",
      "collaborators_url": "https://api.github.com/repos/risaevent/unity24/collaborators{/collaborator}",
      "teams_url": "https://api.github.com/repos/risaevent/unity24/teams",
      "hooks_url": "https://api.github.com/repos/risaevent/unity24/hooks",
      "issue_events_url": "https://api.github.com/repos/risaevent/unity24/issues/events{/number}",
      "events_url": "https://api.github.com/repos/risaevent/unity24/events",
      "assignees_url": "https://api.github.com/repos/risaevent/unity24/assignees{/user}",
      "branches_url": "https://api.github.com/repos/risaevent/unity24/branches{/branch}",
      "tags_url": "https://api.github.com/repos/risaevent/unity24/tags",
      "blobs_url": "https://api.github.com/repos/risaevent/unity24/git/blobs{/sha}",
      "git_tags_url": "https://api.github.com/repos/risaevent/unity24/git/tags{/sha}",
      "git_refs_url": "https://api.github.com/repos/risaevent/unity24/git/refs{/sha}",
      "trees_url": "https://api.github.com/repos/risaevent/unity24/git/trees{/sha}",
      "statuses_url": "https://api.github.com/repos/risaevent/unity24/statuses/{sha}",
      "languages_url": "https://api.github.com/repos/risaevent/unity24/languages",
      "stargazers_url": "https://api.github.com/repos/risaevent/unity24/stargazers",
      "contributors_url": "https://api.github.com/repos/risaevent/unity24/contributors",
      "subscribers_url": "https://api.github.com/repos/risaevent/unity24/subscribers",
      "subscription_url": "https://api.github.com/repos/risaevent/unity24/subscription",
      "commits_url": "https://api.github.com/repos/risaevent/unity24/commits{/sha}",
      "git_commits_url": "https://api.github.com/repos/risaevent/unity24/git/commits{/sha}",
      "comments_url": "https://api.github.com/repos/risaevent/unity24/comments{/number}",
      "issue_comment_url": "https://api.github.com/repos/risaevent/unity24/issues/comments{/number}",
      "contents_url": "https://api.github.com/repos/risaevent/unity24/contents/{+path}",
      "compare_url": "https://api.github.com/repos/risaevent/unity24/compare/{base}...{head}",
      "merges_url": "https://api.github.com/repos/risaevent/unity24/merges",
      "archive_url": "https://api.github.com/repos/risaevent/unity24/{archive_format}{/ref}",
      "downloads_url": "https://api.github.com/repos/risaevent/unity24/downloads",
      "issues_url": "https://api.github.com/repos/risaevent/unity24/issues{/number}",
      "pulls_url": "https://api.github.com/repos/risaevent/unity24/pulls{/number}",
      "milestones_url": "https://api.github.com/repos/risaevent/unity24/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/risaevent/unity24/notifications{?since,all,participating}",
      "labels_url": "https://api.github.com/repos/risaevent/unity24/labels{/name}",
      "releases_url": "https://api.github.com/repos/risaevent/unity24/releases{/id}",
      "deployments_url": "https://api.github.com/repos/risaevent/unity24/deployments",
      "created_at": "2023-10-14T17:40:50Z",
      "updated_at": "2023-10-14T17:40:51Z",
      "pushed_at": "2023-10-14T17:40:51Z",
      "git_url": "git://github.com/risaevent/unity24.git",
      "ssh_url": "git@github.com:risaevent/unity24.git",
      "clone_url": "https://github.com/risaevent/unity24.git",
      "svn_url": "https://github.com/risaevent/unity24",
      "homepage": null,
      "size": 0,
      "stargazers_count": 0,
      "watchers_count": 0,
      "language": null,
      "has_issues": true,
      "has_projects": true,
      "has_downloads": true,
      "has_wiki": true,
      "has_pages": false,
      "has_discussions": false,
      "forks_count": 0,
      "mirror_url": null,
      "archived": false,
      "disabled": false,
      "open_issues_count": 0,
      "license": null,
      "allow_forking": true,
      "is_template": false,
      "web_commit_signoff_required": false,
      "topics": [

      ],
      "visibility": "public",
      "forks": 0,
      "open_issues": 0,
      "watchers": 0,
      "default_branch": "main",
      "score": 1.0
    }
  ]
}
  ''';
  test("fromJson", () async {
    var data = json.decode(jsonData);
    Repository result = Repository.fromJson(data);

    expect(result.total_count, 4);
    expect(result.items.length, 2);

    expect(result.items[0].language, null);
    expect(result.items[0].owner.avatar_url,
        "https://avatars.githubusercontent.com/u/74848706?v=4");
    expect(result.items[0].forks_count, 0);
    expect(result.items[1].name, 'unity24');
    expect(result.items[1].stargazers_count, 0);
  });
}
